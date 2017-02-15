#################
# Luz Frias
# 2017-02-15
# redes neuronales
#################

# Utilizamos el dataset de precios de viviendas en Boston
library(MASS)
library(neuralnet)

# Separamos en train y test
set.seed(1234)
ind_test <- sample(1:nrow(Boston), 0.3 * nrow(Boston))
train <- Boston[-ind_test, ]
test  <- Boston[ ind_test, ]

# Separamos test en variables predictoras y objetivo
test_data <- test[, -14]
test_medv <- test[, 14]

# Preprocesamiento: vamos a normalizar los valores
# En este caso, vamos a concentrar los valores entre [0, 1]
# Primero, calculamos el máximo y mínimo de cada columna
maxs <- apply(Boston, 2, max) 
mins <- apply(Boston, 2, min)

scaled <- as.data.frame(scale(Boston, center = mins, scale = maxs - mins))
# Ejercicio: entender esto que acabamos de hacer. ?scale

train_ <- scaled[-ind_test,]
test_  <- scaled[ ind_test,]

test_data_ <- test_[, -14]
test_medv_ <- test_[, 14]


# Por algún motivo, neuralnet no acepta fórmulas del tipo y ~ .
# Hacemos un truco para generarlo en forma y ~ x1 + x2 + ...
n <- names(train_)
f <- as.formula(paste("medv ~ ", paste(n[!n %in% "medv"], collapse = " + ")))
f

# Entrenamos
# Parámetros importantes
# - linear.output: TRUE para regresiones, FALSE para clasificaciones
# - hidden: cada elemento es una capa, y su valor representa el # neuronas
# - act.fct: función activación
# - algorithm: algoritmo de entrenamiento
# - learningrate
nn <- neuralnet(f, data = train_, hidden = c(5, 3), linear.output = TRUE)

# Visualizamos
plot(nn)

# Predicción
pred_nn_ <- compute(nn, test_data_)$net.result

# Ejercicio: echa un vistazo a las predicciones: ¿qué ocurre?
# Arrégalo en una función y guarda el resultado como pred_nn

# Evaluación del resultado: calculamos el MAE, Mean Absolute Error
nn_mae <- mean(abs(pred_nn - test_medv))
nn_mae

# Ejercicio: compara el resultado frente a una regresión lineal
