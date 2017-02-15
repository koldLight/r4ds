#################
# Luz Frias
# 2017-02-01
# random forests
#################

library(randomForest)

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

# Quitamos columnas que no nos interesan
titanic$name   <- NULL
titanic$ticket <- NULL
titanic$cabin  <- NULL
test$name   <- NULL
test$ticket <- NULL
test$cabin  <- NULL

# ¿Hay NA?
apply(titanic, 2, function(v) length(which(is.na(v))))
apply(test,    2, function(v) length(which(is.na(v))))

# ¿Hay vacíos?
apply(titanic, 2, function(v) length(which(v == "")))
apply(test,    2, function(v) length(which(v == "")))

# Los imputamos a lo fácil y rápido: medianas y modas
median_age  <- median(titanic$age,  na.rm = TRUE)
median_fare <- median(titanic$fare, na.rm = TRUE)
table(titanic$embarked)

titanic[is.na(titanic$age), ]$age  <- median_age
test[   is.na(test$age),    ]$age  <- median_age
test[   is.na(test$fare),   ]$fare <- median_fare
titanic[titanic$embarked == "", ]$embarked <- "S"

# Transformamos la variable objetivo a factor
titanic$survived <- as.factor(titanic$survived)

# Transformamos los factors
titanic$pclass <- as.factor(titanic$pclass)
test$pclass    <- as.factor(test$pclass)

titanic$sex <- as.factor(titanic$sex)
test$sex    <- as.factor(test$sex)

titanic$embarked <- as.factor(titanic$embarked)
test$embarked    <- as.factor(test$embarked)

# Miramos la cantidad total y la proporción de supervivientes
table(titanic$survived)
prop.table(table(titanic$survived))

# Cogemos una porción de los datos para validación
set.seed(1)
ind_val <- sample(x = 1:nrow(titanic), size = nrow(titanic) * 0.3)
validation <- titanic[ind_val, ]
train <-      titanic[-ind_val, ]

# Entrenamos un random forest
rf_100t <- randomForest(formula = survived ~ pclass + sex + age + sibsp + parch + fare + embarked,
                        data = train, ntree = 100, do.trace = FALSE)

# Pintamos el error de cada clase, y el medio
plot(rf_100t)
# ¿Qué pasa? ¿Por qué crees que pasa?

# Importancia de variables: útil para intentar explicar el modelo
varImpPlot(rf_100t)

# Rescatamos la función que hicimos de scoring para decision trees
scoring <- function(model, data_validation) {
  pred <- predict(model, data_validation, type = "class")
  res <- data_validation$survived == pred
  aciertos <- length(which(res))
  total <- nrow(data_validation)
  return(aciertos / total)
}

scoring(rf_100t, validation)

# Ejercicio: ¿mejora si metemos más árboles? Prueba

# Enviemos la predicción a Kaggle con el modelo elegido
pred_rf100t <- predict(rf_100t, test)
submission_rf_100t <- data.frame(PassengerId = test$passengerid, Survived = pred_rf100t)
write.csv(submission_rf_100t, file = "rf_100t.csv", row.names = FALSE, quote = FALSE)

# ¿Ensembles de ensembles? ¡Sí se puede!
?combine

# Ejercicio: intenta mejorar el resultado, balanceando las clases y combinando los árboles
