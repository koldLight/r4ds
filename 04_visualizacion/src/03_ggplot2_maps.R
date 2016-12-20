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

# Geolocalizo Paris
paris <- geocode("paris")

# Descargo el mapa desde Google Maps
map.paris <- get_map( location = as.numeric(paris),
                       color = "color",
                       maptype = "roadmap",
                       zoom = 13)

# Lo pinto
ggmap(map.paris)

# Vamos a pintar algo interesante. Esto ya sabemos hacerlo
library(httr)
res <- GET("https://api.citybik.es/v2/networks/velib")
stop_for_status(res)
info <- content(res)

# Parseamos el json de respuesta
parsed <- lapply(info$network$stations, function(s) c(lat = s$latitude,
                                                      lon = s$longitude,
                                                      name = s$name,
                                                      free_bikes = s$free_bikes,
                                                      empty_slots = s$empty_slots))

velib <- data.frame(matrix(unlist(parsed), ncol = 5, byrow = TRUE), stringsAsFactors = FALSE)
names(velib) <- c("lat", "lon", "name", "free_bikes", "empty_slots")

# Aplicamos las conversiones de tipo
velib$lat         <- as.numeric(velib$lat)
velib$lon         <- as.numeric(velib$lon)
velib$empty_slots <- as.numeric(velib$empty_slots)
velib$free_bikes  <- as.numeric(velib$free_bikes)

# Calculamos % disponible
# Ojo, la división por cero provoca valores NaN
velib$pct_free_bikes  <- velib$free_bikes  / (velib$free_bikes + velib$empty_slots)
velib$pct_empty_slots <- velib$empty_slots / (velib$free_bikes + velib$empty_slots)
velib[is.nan(velib$pct_free_bikes),  ]$pct_free_bikes  <- 0
velib[is.nan(velib$pct_empty_slots), ]$pct_empty_slots <- 0

# Asignamos colores
get_availability <- function(pct) {
  if      (pct < 0.10) "red"
  else if (pct < 0.30) "yellow"
  else                 "green"
}
velib$pick_availability <- sapply(velib$pct_free_bikes,  get_availability)
velib$drop_availability <- sapply(velib$pct_empty_slots, get_availability)

# Por si tenemos que guardar / recuperar los datos limpios
# write.table(velib, file = "dat/velib.tsv", row.names = FALSE, col.names = TRUE, sep = "\t")
# velib <- read.table("dat/velib.tsv", header = TRUE, sep = "\t")

# Lo pinto, añadiendo mis puntos
ggmap(map.paris) + 
  geom_point(aes(x = lon, y = lat, color = pick_availability), data = velib) +
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
