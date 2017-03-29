#################
# Luz Frias
# 2017-03-29
# clustering: jerárquico
#################

library(cluster)
# para mejorar visualizaciones de dendogramas
library(ggplot2)
library(dendextend)
library(d3heatmap)

set.seed(1234)

# Utilizamos el dataset de iris
head(iris)
summary(iris)

# Vamos a coger únicamente las variables del pétalo
iris_c <- as.matrix(iris[, 3:4])

# Normalizamos
iris_c[, 1] <- scale(iris_c[, 1])
iris_c[, 2] <- scale(iris_c[, 2])
summary(iris_c)

# Calculamos cluster jerárquico
clusters <- hclust(dist(iris_c))
plot(clusters)

# Para "podar" el árbol, utilizamos cutree
cluster_cut <- cutree(clusters, 3)

# Miramos el resultado
table(cluster_cut, iris$Species)

# Ejercicio 
# 1. ¿Qué criterio de enlace está usando hclust?
# 2. Cambiálo por otro y repite la operación

iris_r <- as.data.frame(iris_c)
iris_r$Species <- iris$Species

# Pintamos el resultado
ggplot(iris_r, aes(Petal.Length, Petal.Width, color = Species)) + 
  geom_point(alpha = 0.5, size = 3) + 
  geom_point(col = cluster_cut) + 
  scale_color_manual(values = c("black", "red", "green"))

# Algunas visualizaciones chulas

# A modo de dendograma
dend <- as.dendrogram(clusters)
dend <- color_branches(dend, k = 3) 
labels(dend) <- as.character(iris[,5][order.dendrogram(dend)])
dend <- set(dend, "labels_cex", 0.5)
plot(dend)

# A modo de mapa de calor interactivo
d3heatmap(as.matrix(iris_c), dendrogram = "row", Rowv = dend, colors = "Greens", show_grid = FALSE)

# Ejercicio: aplica clustering jerárquico al dataset animals


