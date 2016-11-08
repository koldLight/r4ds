#################
# Luz Frias
# 2016-11-07
# data.table
#################

# data.table está pensada para trabajar con grandes datasets
# Muy conveniente cuando además, accedemos / cruzamos por uno o varios campos
#  determinados (al estilo de primary key en bases de datos)
# cheat.sheet https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf

library(data.table)
library(nycflights13)

# Si tenemos que leer un dataset de fichero, es mucho más rápido utilizar
#  fread (del paquete data.table) que read.table

# Sintaxis general
# DT[i, j, by]
#   R:      i                 j        by
# SQL:  where   select | update  group by

# Los datos: flights. Más info en ?flights
flights.dt <- as.data.table(flights)
flights.dt

# Filtros
flights.dt[month == 1 & day == 1]
# fíjate que no ponemos la coma del final, como en los data.frames de siempre

# Ordenación
flights.dt[order(year, month, day)]
flights.dt[order(-arr_delay)]

# Selección de columnas
flights.dt[, .(year, month, day)]
# aquí, .(algo) es un alias de list(algo)

# Creación de nuevas columnas
flights.dt[, gain := arr_delay - dep_delay]

# Resumen
flights.dt[, .(delay = mean(dep_delay, na.rm = TRUE))]

# Nuevas columnas por agrupaciones
flights.dt[, c("min_ori_delay", "max_ori_delay") := 
             .(min(arr_delay, na.rm = TRUE), max(arr_delay, na.rm = TRUE)),
           by = origin]

# Resúmenes por agrupaciones
flights.dt[, .(min_ori_delay = min(arr_delay, na.rm = TRUE),
               max_ori_delay = max(arr_delay, na.rm = TRUE)),
           by = origin]

# Operaciones de agregación:
# - .N: cuenta las filas en el grupo
# - max, min, sd, median, mean, sum, ...
flights.dt[, .(count = .N), by = origin]
# Y si además queremos ordenar por el by...
flights.dt[, .(count = .N), keyby = origin]
# Con operaciones en el by
flights.dt[, (.count = .N), by = .(dep_delay>0, arr_delay>0)]

# Otros símbolos especiales, además de .N
# .SD: Subset of Data. Contiene los datos del grupo
flights.dt[, head(.SD, 2), by = month]
# .SDcols: para especificar las columnas que hay en .SD
flights.dt[carrier == "AA",                       ## Filtro para carrier "AA"
           lapply(.SD, mean),                     ## calcula la media de las columnas
           by = .(origin, dest, month),           ## agrupando por origin, dest y month
           .SDcols = c("arr_delay", "dep_delay")] ## para lo especificado en .SDcols
# ¿qué pasa si quito .SDcols?

# Chaining
flights.dt[carrier == "AA", .N, by = .(origin, dest)][order(origin, -dest)]

# Ejercicio
# Calcula cuál es el destino al que llegan más vuelos de corta distancia
#  (distancia inferior a 2000) por mes. Incluye también en la salida
#  el número de vuelos

# Copia
# no vale con hacer new.dt <- old.dt
# en data.table, las modificaciones se hacen por referencia
# p.ej.
dt1 <- data.table(col1 = 1:4, col2 = letters[1:4])
dt2 <- dt1
dt2[, col3 := 4:1]
dt2

# Hay que hacer copia explícita
dt <- copy(flights.dt)

# De una columna
setkey(flights.dt, origin)
head(flights.dt)
flights.dt["JFK"]
key(flights.dt)

# O varias
setkey(flights.dt, origin, dest)
flights.dt[.("JFK", "MIA")]

# Acceder por clave es mucho más rápido que un escaneo tradicional
system.time(dt[origin == "JFK" & dest == "MIA"])
system.time(flights.dt[.("JFK", "MIA")])

# Eliminar la key
setkey(flights.dt, NULL)

# Lead y lag
# Ejercicio: mira la ayuda de ?shift y contesta, para cada vuelo (cada fila de flights.dt)
#  las siguientes preguntas, creando dos nuevas columnas:
# 1. prev_flight: ¿Hace cuánto salió un avión con el mismo origen y destino?
# 2. next_flight: ¿Cuándo saldrá el siguiente?
# pista: difftime(t1, t2, units = "hours")

