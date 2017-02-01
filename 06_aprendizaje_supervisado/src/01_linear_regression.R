#################
# Luz Frias
# 2017-02-01
# linear regression
#################

# Velocidad frente a distancia de frenado
summary(cars)
plot(cars)
# Parece que hay una relación lineal entre ellas, ¿no?

# Antes de aplicar una regresión lineal en la que las variables están en diferentes
# unidades o escalas, es recomendable normalizarlas. El efecto influye en cómo interpretamos
# la respuesta
# Normalizar (hay más formas) habitualmente es:
#  * Centrar: se le resta la media
#  * Escalar: se divicen los valores centrados entre la desviación estándar

my_cars <- cars
my_cars$speed <- as.numeric(scale(my_cars$speed, center = TRUE, scale = TRUE))

# Vemos el efecto de centrarlo
mean(cars$speed)
mean(my_cars$speed)

# Ajustamos una regresión lineal
cars_model <- lm(formula = dist ~ speed, data = my_cars)
summary(cars_model)

# Explicación de la salida:
#  * Residuos: Son la diferencia entre los valores reales y los predichos por el modelo
#              Idealmente, debería ser simétrica y con valores pequeños
#  * Coeficientes: y = x0 + x1*v1 + x2*v2 + ... + E
#    * Intercept, variables: intercept es x0, es decir, el valor de la predicción cuando
#                            las variables son 0. Como tenemos solo una y la hemos centrado
#                            es el valor de la distancia cuando la velocidad es la media
#    * Estimado y error estándar: el estimado es el valor de x0, x1, ... El error estándar
#                                 mide cuánto dista el coeficiente de la media de la respuesta
#                                 real. Idealmente, buscamos valores bajos
#    * p-valor: mide la probabilidad de que la hipótesis nula sea cierta. La hipótesis nula es
#               que el coeficiente sea 0, es decir, que no haya relación entre esta variable
#               y el valor objetivo. Se suele establecer 0.05 como punto de corte: si es menor,
#               se rechaza la hipótesis nula. Las *** son otra forma de representar el p-valor
#  * Error residual estándar: mide la calidad del ajuste. Es la media de lo que dista el valor
#                             de la línea de regresión
#  * R-squared y adjusted R-squared: otra forma de medir la calidad del ajuste, entre 0 y 1.
#                                    0 implica que la regresión no explica la variable objetivo,
#                                    un valor cercano a 1 sí.
#  * F-statistic: buen indicador para ver si hay una relación entre las predictoras y la objetivo.
#                 Cuanto más se aleje de 1, mejor, aunque depende de la cantidad de datos de
#                 entrenamiento. Si hay muchos datos, con que se aleje un poco de 1, suele valer para
#                 rechazar la hipótesis nula

# Pintamos los resultados
plot(my_cars)
abline(cars_model)

# Predecir
new_cars <- data.frame(speed = c(-1, -0.5, 0, 0.5, 1))
predict(cars_model, new_cars)

# Un ejercicio entre todos

library(MASS)
?Boston

# Ejercicio regresión simple
# Nota: no normalizamos en este ejemplo, esto influye en cómo interpretamos los coeficientes
# 1. ¿Crees necesario separar entre train y test? ¿Por qué?
# 2. Separa en dos conjuntos, train y test (70 - 30)
# 3. Ajusta una regresión de medv frente a lstat
# 4. Interpreta los resultados
# 5. Pinta los datos frente a la recta

# Ejercicio interacciones
# Las interacciones ocurren cuando varía el efecto de la variable predictora v1 en base a otra v2
# Por ejemplo, imaginemos que tenemos:
# - Variable objetivo: sobrevive o no
# - Variables predictoras: gravedad enfermedad y tratamiento (medicamento o placebo)
# Existe una interacción entre gravedad enfermedad y tratamiento

# Dos formas de representarlas en la fórmula:
# v1:v2 es la interacción en sí
# v1*v2 es una forma de representar v1+v2+v1:v2

# 1. Ajusta una regresión de medv frente a la interacción entre lstat, age y su interacción
# 2. Interpreta el resultado

# Ejercicio regresión no lineal
# Se puede user I para introducir relaciones no lineales, p.ej., I(v1^2)
# 1. Ajusta una regresión de medv frente a lstat y lstat al cuadrado

# Ejercicio con todas las variables
# 1. Ajusta una regresión de medv frente a todas las variables
# 2. Interpreta el resultado

