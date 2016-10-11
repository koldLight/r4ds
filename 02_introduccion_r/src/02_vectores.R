#################
# Luz Frias
# 2016-10-10
# Vectores
#################

# Los índices empiezan en 1 (no en 0)
# Todos los elementos son del mismo tipo

# Asignación
# Vectores numéricos, de caracteres, lógicos, ...
# Pueden tener nombre
v1 <- c(primero = "a", segundo = "b")
v2 <- c(TRUE, TRUE, FALSE)
mode(v1)
length(v2)
v3 <- rep(2, 3)
v4 <- 3:8

# Indexación
v1[1]
v1["segundo"]
v4[2:4]
v4[c(TRUE, FALSE, FALSE, FALSE, FALSE, TRUE)]
v4[-1] # índices negativos DESCARTAN valores (todos menos este)
v1["segundo"] <- "c"

# Operaciones
c(1, 2, 3) + 10
c(1, 2, 3, 4) + c(10, 20) # repite el menor
as.numeric(v2)
as.character(v2)

# Ejercicio
# 1. Mira la documentación de la función rnorm
# 2. Genera un vector de 1000 elementos con valores generados aleatoriamente
#  que sigan una distribución normal con media = 5 y desviación estándar = 2
# 3. Pinta el histograma con la función hist
# 4. Calcula la media y la desviación estándar (mean, sd) y comprueba que
#  son correctos
# 5. Sustituye el primer valor de tu vector por NA.
# 6. Calcula la media ahora. ¿Qué pasa?
# 7. Mira la documentación de ?mean para ver cómo ignorar los NAs
