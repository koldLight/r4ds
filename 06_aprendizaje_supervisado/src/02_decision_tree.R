#################
# Luz Frias
# 2017-02-01
# decision trees
#################

library(rpart)
library(ggplot2)

# Usamos el dataset del Titanic
# https://www.kaggle.com/c/titanic/data

# Leemos los datos
titanic <- read.csv("../dat/train.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
test    <- read.csv("../dat/test.csv",  header = TRUE, sep = ",", stringsAsFactors = FALSE)
names(titanic) <- tolower(names(titanic))
names(test) <- tolower(names(test))

# Qué pinta tienen
summary(titanic)
sapply(titanic, class)
head(titanic)

# Ejercicio: ¿es verdad eso de primero mujeres y niños? ¿y qué se priorizó a las clases altas?
# Pinta con ggplot:
# Eje x: clase
# Eje y: conteo
# Con facets, un gráfico para supervivientes y otro para no

# Miramos la cantidad total y la proporción de supervivientes
table(titanic$survived)
prop.table(table(titanic$survived))

# Miramos la cantidad total y proporción de supervivientes en base al sexo
table(titanic$sex, titanic$survived)
prop.table(table(titanic$sex, titanic$survived))

# Ejercicio
# Crea una nueva feature indicando si es niño o no
# Realiza la misma comparación, y prueba con diferentes cortes de edad

# Cogemos una porción de los datos para validación
set.seed(1)
ind.val <- sample(1:nrow(titanic), nrow(titanic) * 0.3)
validation <- titanic[ind.val, ]
train <-      titanic[-ind.val, ]

# Entrenamiento de un árbol de decisión
tree_1 <- rpart(survived ~ sex + age, data = train, method = "class")
plot(tree_1, margin=0.2)
text(tree_1)

# Un poco feo, vamos a pintarlo mejor
library(rattle)
# En OSX puede dar problemas la instalación de rattle por dependencia con GTK+, arreglado con:
#  brew install gtk2 && sudo gem install gtk2
#  install.packages("RGtk2", dependencies = T, type = 'mac.binary.mavericks')
#  install.packages("...downloaded_packages/RGtk2_2.20.31.tgz", repos=NULL)
library(rpart.plot)
library(RColorBrewer)

fancyRpartPlot(tree_1)
# Cada división contiene:
# - La clase mayoritaria
# - La proporción de cada clase
# - La proporción del conjunto global de datos que contiene

# Ejercicio
# 1. Crea un nuevo árbol tree_all utilizando todas las variables
# 2. Crea un nuevo árbol tree_2 utilizando solo variables que consideres con poder predictivo
# 3. Crea un nuevo árbol controlando su construcción (?rpart.control)

# Predicciones, se pueden extraer en diferentes tipos de respuesta
tree_1_pred <- predict(tree_1, validation, type = "class")
tree_1_prob <- predict(tree_1, validation, type = "prob")

# Scoring the prediction
# Confussion matrix
table(validation$survived, tree_1_pred)

# Probabilidad: lo ideal, que el modelo acierte mucho cuando la probabilidad es extrema
#  y falle cuando es cercana a 0.5 (es decir, dude en los casos menos claros)
# Ejercicio: para verlo, pinta con ggplot un gráfico que tenga:
# - Eje x: la probabilidad de la predicción
# - Eje y: el conteo de observaciones
# - Relleno de color: si sobrevive o no

# Necesitamos una función de evaluación, para comprar el rendimiento
# Ejercicio: crea una función que acepte un árbol y devuelva un scoring que sea aciertos / total
#  con ella, compara los diferentes árboles

# Enviemos la predicción a Kaggle con el modelo elegido
test_pred <- predict(tree_1, test, type = "class")
submission_1 <- data.frame(PassengerId = test$passengerid, Survived = test_pred)
write.csv(submission_1, file = "submission_1.csv", row.names = FALSE)
