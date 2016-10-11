#################
# Luz Frias
# 2016-10-10
# funciones
#################

# Funciones
suma <- function(x, y) {
  #return(x + y)
  x + y
}

suma(2, 3)

# En una línea
suma <- function(x, y) x + y

# Parámetros opcionales y valores por defecto
hello <- function(nombre, saludo = "Hello") {
  paste(saludo, nombre)
}
hello("Pepe")
hello("Pepe", "Hola")

# Argumentos por nombre
hello(saludo = "Hola", nombre = "Pepe")

# Argumentos en lista
f_tail <- function(...) {
  c(...)[-1]
}
f_tail(1, 2, 3)

# Argumentos por valor
a <- 1
foo <- function(x) {
  a <- 2
}
foo()
a

# O se pueden leer las variables del entorno padre con <<-
#  aunque no es recomendable
cur <- 0
acumula <- function(x) {
  cur <<- cur + x
  cur
}

acumula(2)
acumula(3)
acumula(4)
cur

# Ejercicios
# Escribe lapply2 que simule el comportamiento de lapply
# - Primero, sin argumentos extra para la función
#   Prueba, por ejemplo: lapply2(list(-1,2,-3), abs)
# - Luego con ellos
#   Prueba, por ejemplo: lapply2(list(-1,2,-3), rep, 3)

