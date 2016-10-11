#################
# Luz Frias
# 2016-10-10
# dataframes
#################

# Generación
df <- data.frame(numero = 1:12, nombre = month.name)

# Lectura y escritura en fichero
write.table(iris, file = "iris.tsv", sep = "\t", col.names = TRUE,
            row.names = FALSE)
iris_df <- read.table("iris.tsv", header = TRUE, sep = "\t",
                      stringsAsFactors = FALSE)

# Exploración
dim(iris_df)
nrow(iris_df)
ncol(iris_df)
summary(iris_df)
head(iris_df)
sapply(iris_df, class)
# Ejercicio: entender qué hace sapply(iris_df, class)
names(iris_df)

# Indexación
iris_df[1:5, ]
iris_df[1:5, c(1, 5)]
iris_df[1:5, "Sepal.Length"]
iris_df[1:5, -1]
iris_df[iris_df$Sepal.Width > 4, ]

# Crear y eliminar columnas
iris_df$random <- rnorm(nrow(iris_df), 0, 1)
iris_df$random <- NULL

# Cruce de dataframes (join)
especies <- unique(iris_df$Species)[-1]
iris_2 <- data.frame(Species = especies, numero = 1:length(especies))
cruce <- merge(iris_df, iris_2)   # inner join
dim(cruce)
cruce <- merge(iris_df, iris_2, all.x = TRUE) # outer join
head(cruce)

# Ejercicio
# Consulta para qué sirven read.csv y write.csv
# Úsalas para guardar y leer de nuevo iris
# Comprueba que se haya leido correctamente