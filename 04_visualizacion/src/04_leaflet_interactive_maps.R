#################
# Luz Frias
# 2016-12-20
# leaflet - Mapas interactivos
#################

# Para esto, no utilizamos ggplot2. En su lugar, utilizamos leaflet
library(leaflet)

# Leemos los datos, si no los tenemos calculados ya
velib <- read.table("dat/velib.tsv", header = TRUE, sep = "\t")

# Extendemos la información en un popup
velib$popup <- paste0("<span><strong>",      velib$name,        "</span></strong><br/>",
                      "<span>Free bikes: ",  velib$free_bikes,  "</span><br/>",
                      "<span>Empty slots: ", velib$empty_slots, "</span><br/>")

# Pintamos, de manera similar a con ggplot2
map <- leaflet(velib) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircleMarkers(lng = ~lon, lat = ~lat, popup = ~popup,
                   color = ~pick_availability, group = "Pick availability") %>%
  addCircleMarkers(radius = 2, opacity = 1, lng = ~lon, lat = ~lat, popup = ~popup,
                   color = ~drop_availability, group = "Drop availability") %>%
  addLayersControl(
    baseGroups = c("Pick availability", "Drop availability"),
    options = layersControlOptions(collapsed = FALSE)
  )

map
