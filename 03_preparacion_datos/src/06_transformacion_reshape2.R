#################
# Luz Frias
# 2016-10-25
# reshape2
# Basado en http://seananderson.ca/2013/10/19/reshape.html
#################

library(reshape2)

# reshape2 permite cambiar entre formato ancho y largo en un data.frame
# - Formato ancho: una columna por atributo
# - Formato largo: una columna describiendo el tipo de atributo, y otra
#  su valor

names(airquality) <- tolower(names(airquality))
head(airquality)

# melt: de ancho a largo
largo <- melt(airquality)
head(largo)

largo <- melt(airquality, id.vars = c("month", "day"),
              variable.name = "climate_variable", 
              value.name = "climate_value")
head(largo)

# cuidado con los tipos de datos, que van a una misma columna!

# dcast: de largo a ancho
largo <- melt(airquality, id.vars = c("month", "day"))
ancho <- dcast(largo, month + day ~ variable)
head(ancho)

# fíjate en la fórmula: la parte de la izquierda son variables que
#  seguirán como columnas, y la de la derecha, las que se convertirán
#  de valores a columnas

# un error común: crear un dataset que tiene más de un valor por celda
dcast(largo, month ~ variable)

# está bien si queremos agregar la información
dcast(largo, month ~ variable, fun.aggregate = mean, na.rm = TRUE)

# Ejercicio:
# 1. Carga el dataset sobre patatas fritas con
# data(french_fries)
# 2. Pásalo a formato largo, de forma que potato, buttery, grassy,
#  rancid, painty pasen a ser clave-valor
# 3. Vuelve a pasarlo a formato ancho, sin perder filas
# 4. Partiendo del formato largo, saca la media por tratamiento y "variable" 
#  (potato / buttery / grassy ...) 
