#################
# Luz Frias
# 2016-10-25
# APIs (JSON y otros)
#################

library(httr)

# Parámetros de la petición
query.parms <- list(
  lat = 36.9003409,
  lon = -3.4244838
)

# URL destindo
url <- "http://www.cartociudad.es/services/api/geocoder/reverseGeocode"

# Llamada al servicio y espera a respuesta
res <- GET(url, query = query.parms)
stop_for_status(res)

# Extracción del contenido, de JSON a lista
# Ver: http://www.cartociudad.es/services/api/geocoder/reverseGeocode?lat=36.9003409&lon=-3.4244838
info <- content(res)

# Más información de la respuesta
status_code(res)
headers(res)

# Un ejemplo con POST
url <- "http://httpbin.org/post"
body <- list(a = 1, b = 2, c = 3)

# Diferentes codificaciones
# Con verbose() vemos qué se manda exactamente al servidor
r <- POST(url, body = body, encode = "form", verbose())
r <- POST(url, body = body, encode = "multipart", verbose())
r <- POST(url, body = body, encode = "json", verbose())

# Ejercicio
# 1. Pregunta a la API de Nominatim de a dónde (calle, ciudad, ...)
#  pertenecen estas coordenadas: 51.4965946,-0.1436476
# 2. Pregunta a la API de la policía de UK por crímenes cometidos cerca
#  de esa localización en Julio de 2016
# 3. A partir de la respuesta, haz un conteo de los crímenes que ha habido
#  por categoría. Pista: puedes usar sapply y table
#
# Doc de las APIs
# http://wiki.openstreetmap.org/wiki/Nominatim#Reverse_Geocoding
# https://data.police.uk/docs/method/crimes-at-location/
