#################
# Luz Frias
# 2016-10-25
# XML y HTML
# Basado en: http://yihui.name/en/2010/10/grabbing-tables-in-webpages-using-the-xml-package/
#################

library(XML)

elecciones.url <- "http://resultados.elpais.com/resultats/eleccions/2016/generals/congreso/"
tablas <- readHTMLTable(elecciones.url, stringsAsFactors = FALSE)

# Ejercicio
# 1. ¿Qué le pasa a la cabecera de la tabla? ¿Por qué? Arréglalo
# 2. ¿Qué le pasa a los tipos de datos? ¿Por qué? Arréglalo. Pista: ?gsub
# 3. Pinta con plot el número de votos versus el número de escaños de los partidos
#  excluyendo a los 4 más votados


# Otra forma: con XPath
# referencia ejemplo: https://gist.github.com/izahn/5785265
# documentación XPath: http://ricostacruz.com/cheatsheets/xpath.html
library(RCurl)

## Descarga de RSS
xml.url <- "http://rss.cnn.com/rss/cnn_topstories.rss"
script <- getURL(xml.url, ssl.verifypeer = FALSE)

## Conversión a árbol XML
doc <- xmlParse(script)

## Extracción de información con XPath
titles <- xpathSApply(doc,'//item/title',xmlValue)
pubdates <- xpathSApply(doc,'//item/pubDate',xmlValue)
categories <- xpathSApply(doc,'//item/category',xmlValue)
links <- xpathSApply(doc,'//item/feedburner:origLink',xmlValue)
descriptions <- xpathSApply(doc,'//item/description',xmlValue)
