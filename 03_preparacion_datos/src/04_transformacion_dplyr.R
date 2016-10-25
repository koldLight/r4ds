#################
# Luz Frias
# 2016-10-25
# dplyr
# Basado en las vignettes de dplyr
#################

# dplyr es una evolución de plyr, con una gran mejora en rendimiento

library(dplyr)
library(nycflights13)

# Los datos: flights. Más info en ?flights
dim(flights)
head(flights)
sapply(flights, class)
flights # sin miedo a que pete la salida!

# Filtros
filter(flights, month == 1, day == 1)
filter(flights, month == 1 & day == 1)
# Más elegante que el clásico flights[flights$month == 1 & flights$day == 1, ]

# Ordenación
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))
# Equivalente: flights[order(flights$arr_delay, decreasing = TRUE), ]

# Selección de columnas
select(flights, year, month, day)
select(flights, year:day) # por rangos de columnas, equivalente a lo de arriba

# Extración de valores únicos
distinct(flights, origin, dest)

# Creación de nuevas columnas
mutate(flights, gain = arr_delay - dep_delay)

# Resumen
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# Selección de filas aleatoriamente (sample)
sample_n(flights, 10)      # por número de filas
sample_frac(flights, 0.01) # por fracción

# Agrupaciones
# Ver el retraso medio por ID de vuelo, siempre que haya más de
#  20 observaciones y la distancia media sea inferior a 2000km
by_tailnum <- group_by(flights, tailnum)
delay <- summarise(by_tailnum,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)

# Operaciones de agregación:
# - n(): cuenta las filas
# - n_distinct(x): cuenta valores únicos de x
# - first(x), last(x): primer y último valor de x
# - max, min, sd, median, mean, sum, ...

# Otro ejemplo: ¿cuántos aviones llegan a cada destino?
destinations <- group_by(flights, dest)
summarise(destinations,
          planes = n_distinct(tailnum),
          flights = n()
)

# Chaining
# Podemos concatenar funciones con el pipe %>% (como en bash y otros lenguajes)
# Por ejemplo, los dos ejemplos de arriba se pueden escribir así:
flights %>%
  group_by(tailnum) %>%
  summarise(count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(count > 20, dist < 2000)

flights %>%
  group_by(dest) %>%
  summarise(planes = n_distinct(tailnum),
            flights = n())

# Ejercicio
# Calcula cuál es el destino al que llegan más vuelos de corta distancia
#  (distancia inferior a 2000) por mes. Incluye también en la salida
#  el número de vuelos
