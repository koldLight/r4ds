#################
# Luz Frias
# 2017-03-29
# clustering: DBSCAN
#################

library(fpc)
library(factoextra)

# Vamos a coger un dataset
data("multishapes")
df <- multishapes[, 1:2]
plot(df)

# Ejercicio: aplica k-medias y pinta el resultado. ¿Qué pasa?
clusters <- kmeans(df, centers = 5)
ggplot(data = df, aes(x = x, y = y)) + 
  geom_point(aes(color = as.factor(clusters$cluster)))

# Vamos a probar con un algoritmo basado en densidad
df <- multishapes[, 1:2]
db_res <- dbscan(df, eps = 0.2, MinPts = 10)
df$db_cluster <- as.factor(db_res$cluster)

# Pintamos
ggplot(data = df, aes(x = x, y = y)) + 
  geom_point(aes(color = db_cluster))

# Ejercicio: haz clústering sobre algún dataset de https://cs.joensuu.fi/sipu/datasets/, 
#  comparando los resultados que salen usando un método u otro
