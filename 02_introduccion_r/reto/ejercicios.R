#################
# Luz Frias
# 2016-10-12
# reto
# basado en: https://cran.r-project.org/doc/manuals/R-intro.pdf
#################

# Ejercicio 1: dado x construido de la siguiente manera
w <- c(2, 7, 8)
v <- c("A", "B", "C")
x <- list(w, v)
# escribe una nueva sentencia que reemplace "A" por "K" en la lista x

# Ejercicio 2: dado a
a <- list ("x"=5, "y"=10, "z"=15)
# calcula en una sentencia la suma de sus elementos
# pista: ?unlist

# Ejercicio 3: dado
b <- list(a=1:10, b=seq(3), c=rep(2, 5))
# escribe una sentencia que devuelva un vector con la longitud de cada uno de los elementos de lista

# Ejercicio 4
c <- list(a=1:10, c="Hello", d="AA")
# escribe una sentencia que devuelva todos los elementos de la lista menos el primero

# Ejercicio 5
d <- list(a=5:10, c="Hello", d="AA")
# escribe una sentencia que añada al final de d un elemento "ZZ"

# Ejercicio 6
e <- list("a", "b", "c")
# escribe una sentencia que asigne como nombres de elementos "one", "two" and "three" a e

# Ejercicio 7
f <- list(1, 5, 7)
g <- list(2, 5, 8)
# escribe una sentencia que devuelva los valores de f que no están en g
# pista: ?`%in%`

# Ejercicio 8
# A partir del dataset state.center ya cargado en R
# Comprueba el tipo de dato, examínalo y conviértelo a data.frame

# Ejercicio 9
# Crea un data.frame con 3 columnas a partir de 3 vectores numéricos a tu gusto
# Ordena las filas de manera descendente con los valores de la primera columna
# pista: ?order

# Ejercicio 10
# A partir del data.frame
h <- as.data.frame(diag(4))
# Renombra los nombres de las filas para que se llamen i_row (es decir, 1_row, 2_row, ...)
# y las columnas a j_col (es decir, 1_col, 2_col, ...)
# pista: puedes utilizar rownames, colnames, nrow, ncol, paste0 y sapply

# Ejercicio 11
# A partir del dataset VADeaths ya cargado en R
# a) Comprueba si es un data.frame y si no, conviértelo

# b) Crea una una columna Total con la suma de cada fila

# c) Cambia de orden las columnas, de forma que Total sea la primera

# Ejercicio 12
# A partir del dataset state.x77 ya cargado en R
# a) Comprueba si es un data.frame y si no, conviértelo

# b) Extrae el número de estados con un ingreso menor a 4300

# c) Extrae el estado con el ingreso más alto. Pista: ?which

# Ejercicio 13
# A partir del dataset swiss, crea un data.frame únicamente con las filas
# 1, 2, 3, 10, 11, 12 and 13, y solo con las columnas Examination, Education and Infant.Mortality

# a) La mortalidad infantil de Sarine está mal, debería ser NA, cámbialo.

# b) Crea una columna Total con la suma de cada fila. Si te encuentras NAs, ignóralos (suman 0)

# c) Crea una columna of con la proporción de Examination (Examination / Total)
