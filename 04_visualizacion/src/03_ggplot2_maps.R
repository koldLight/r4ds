#################
# Luz Frias
# 2016-12-20
# ggplot2 - Mapas
#################

# Qué necesitamos para pintar datos sobre mapas:
# - La definición del mapa (límites de áreas). A veces no es fácil encontrar mapas de dominio
#  público que contengan la definición de los polígonos que forman un mapa. El paquete de R
#  "maps" contiene algunos: de Francia, Italia, Estados Unidos, del mundo, ...
# - Datos geo-referenciados. Pueden estar vinculados a:
#   - Puntos: latitud y longitud
#   - Áreas: identificadas por código o nombre, y que vienen delimitadas en la definición
#    del mapa

library(ggplot2)

# Cheatsheet ggplot: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

###################
# Mapas con áreas #
###################

# Definición del mapa
library(maps)

states_map <- map_data("state")
# states contiene la definición de los polígonos que forman cada estado
head(states_map)

# Datos geo-referenciados
states_dat <- data.frame(state = tolower(rownames(state.x77)), 
                         income = state.x77[, "Income"])

# ggplot para pintar el mapa

ggplot(states_dat, aes(map_id = state)) +
  geom_map(aes(fill = income), map = states_map) + 
  expand_limits(x = states_map$long, y=states_map$lat) + 
  coord_map() +
  scale_fill_continuous(low = "yellow", high = "blue")

# Ejercicio
# 1. Lee los datos del data.frame USArrests
# 2. Crea un gráfico que muestre el mapa de EEUU con sus estados, y el color de cada estado
#  refleje la cantidad de asesinatos ocurridos

####################
# Mapas con puntos #
####################

library(ggmap)

# ggmap llama a la API de Google Maps para recuperar la imagen estática del mapa

# Geolocalizo Barcelona
bcn <- geocode("eixample, barcelona")

# Descargo el mapa desde Google Maps
map.bcn <- get_map( location = as.numeric(bcn),
                    color = "color",
                    maptype = "roadmap",
                    zoom = 13)

# Lo pinto
ggmap(map.bcn)

# Vamos a pintar algo interesante. Esto ya sabemos hacerlo
library(httr)
res <- GET("https://api.citybik.es/v2/networks/bicing")
stop_for_status(res)
info <- content(res)

# Parseamos el json de respuesta
parsed <- lapply(info$network$stations, function(s) c(lat = s$latitude,
                                                      lon = s$longitude,
                                                      name = s$name,
                                                      free_bikes = s$free_bikes,
                                                      empty_slots = s$empty_slots))

bicing <- data.frame(matrix(unlist(parsed), ncol = 5, byrow = TRUE), stringsAsFactors = FALSE)
names(bicing) <- c("lat", "lon", "name", "free_bikes", "empty_slots")

# Aplicamos las conversiones de tipo
bicing$lat         <- as.numeric(bicing$lat)
bicing$lon         <- as.numeric(bicing$lon)
bicing$empty_slots <- as.numeric(bicing$empty_slots)
bicing$free_bikes  <- as.numeric(bicing$free_bikes)

# Calculamos % disponible
# Ojo, la división por cero provoca valores NaN
bicing$pct_free_bikes  <- bicing$free_bikes  / (bicing$free_bikes + bicing$empty_slots)
bicing$pct_empty_slots <- bicing$empty_slots / (bicing$free_bikes + bicing$empty_slots)
if (length(which(is.nan(bicing$pct_free_bikes)))) {
  bicing[is.nan(bicing$pct_free_bikes),  ]$pct_free_bikes  <- 0
}
if (length(which(is.nan(bicing$pct_empty_slots)))) {
  bicing[is.nan(bicing$pct_empty_slots), ]$pct_empty_slots <- 0
}

# Asignamos colores
get_availability <- function(pct) {
  if      (pct < 0.10) "red"
  else if (pct < 0.30) "yellow"
  else                 "green"
}
bicing$pick_availability <- sapply(bicing$pct_free_bikes,  get_availability)
bicing$drop_availability <- sapply(bicing$pct_empty_slots, get_availability)

# Por si tenemos que guardar / recuperar los datos limpios
# write.table(bicing, file = "dat/bicing.tsv", row.names = FALSE, col.names = TRUE, sep = "\t")
# bicing <- read.table("dat/bicing.tsv", header = TRUE, sep = "\t")

# Lo pinto, añadiendo mis puntos
ggmap(map.bcn) + 
  geom_point(aes(x = lon, y = lat, color = drop_availability), data = bicing) +
  # ggmap asigna un color por defecto a cada valor del parámetro "color"
  # para mapear a algo que tenga sentido
  scale_colour_manual(values = c("green" = "green",
                                 "yellow" = "yellow",
                                 "red" = "red"))

###################
# Mapas con rutas #
###################

# Es igual que el caso anterior (ggmap), pero utilizamos geom_path para pintar rutas

# Ejercicio
# 1. Lee los datos de dat/bike.csv
# 2. Localiza con ggmap un mapa en -122.080954, 36.971709, de tipo terreno y zoom 14
# 3. Pinta la ruta en bici sobre el mapa
# 4. Colorea la ruta según la elevación. Haz un poco más ancha la línea para que se aprecie.
