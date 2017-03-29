#################
# Luz Frias
# 2017-03-29
# clustering: k-means
#################

library(cluster)
library(ggplot2)

# Utilizamos el dataset de iris
head(iris)
summary(iris)

# Vamos a coger únicamente las variables del pétalo
iris_c <- as.matrix(iris[, 3:4])

# Normalizamos
iris_c$Petal.Length <- scale(iris_c$Petal.Length)
iris_c$Petal.Width  <- scale(iris_c$Petal.Width)
summary(iris_c)

# Calculamos k-medias
clusters <- kmeans(iris_c, 3)

# Como salida, tenemos algunos valores interesantes
clusters$size      # Tamaño de cada cluster
clusters$centers   # Los centros
clusters$withinss  # Distancia intra-cluster

# Vamos a pintar los resultados
iris_r <- iris

# Pegamos la información del clúster a cada fila del dataset original
iris_r$cluster <- factor(clusters$cluster)

# Pintamos
ggplot(data = iris_r, aes(x = Petal.Length, y = Petal.Width)) + 
  geom_point(aes(color = cluster)) + 
  geom_point(data = as.data.frame(clusters$centers), aes(color="Center"), shape = 3, size = 3,
             show.legend = FALSE)

# Vamos a ver si la clasificación en clusters corresponde con las especies
table(iris_r$Species, iris_r$cluster)

# Pintamos los valores que se han clasificado "mal"
equivocados <- iris_r[iris_r$cluster == 1 & iris_r$Species != "setosa", ]
equivocados <- rbind(equivocados, iris_r[iris_r$cluster == 2 & iris_r$Species != "virginica", ])
equivocados <- rbind(equivocados, iris_r[iris_r$cluster == 3 & iris_r$Species != "versicolor", ])
equivocados

ggplot(data = iris_r, aes(x = Petal.Length, y = Petal.Width, color = cluster)) + 
  geom_point() + 
  geom_point(data = as.data.frame(clusters$centers), aes(color="Center"), shape = 3, size = 3,
             show.legend = FALSE) +
  geom_point(data=equivocados, aes(alpha = .7, size = 4.5), shape = 5, show.legend = FALSE) 

# Ejercicio: pinta la relación entre el número de clusters y la distancia intra-cluster, simulándola

# Ejercicio: repite el problema utilizando k-mediodes (ver ?pam)

# Ejercicio: utiliza plot sobre el resultado de pam, para ver el gráfico de silueta.
#  ¿Qué forma deberemos buscar en el caso ideal?
