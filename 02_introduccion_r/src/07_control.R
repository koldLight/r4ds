#################
# Luz Frias
# 2016-10-10
# control de flujo y bucles
#################

# for
for (i in 1:10) {
  print(i)
}

for (i in c(4,7,9)) {
  print(i)
}

for (i in seq(3)) {
  print(i)
}

a <- c(3,6,9)
for (i in seq_along(a)) {
  print(paste0(i, ": ", a[i]))
}

# Otras estructuras: while, repeat
# https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r

# Condicionales
ifelse(1 > 4, "si", "no")

if (1 > 4) {
  "no pasa por aqui"
} else if (2 > 4) {
  "tampoco"
} else {
  "aquí si"
}

# &, &&, | y ||
a <- c(TRUE, FALSE, TRUE)
b <- c(FALSE, FALSE, TRUE)

# & y | son vectorizadas
a & b
a | b

# && y || no. Además, son perezosas
if (1 < 2 && 2 < 3) {
  "se cumple"
}

if (2 > 1 || stop("error")) {
  "cierto, y no hace falta evaluar el segundo operando"
}

# Ejercicio:
# Escribe algo equivalente al último caso con &&
# Es decir, que el segundo operador sea un stop() pero nunca se evalúe
