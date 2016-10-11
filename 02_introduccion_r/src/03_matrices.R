#################
# Luz Frias
# 2016-10-10
# Matrices
#################

# Generación
M <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3, byrow = TRUE)
I <- diag(3) # matriz diagonal de 3x3

# Exploración
dim(M)
summary(M)

# Indexación
M[2, 3]
M[1, ]

# Concatenación
cbind(M, I)
rbind(M, I)

# Nombres de columna
colnames(M) <- c("a", "b", "c")
colnames(M)

# Conversiones
as.data.frame(M)

# Operaciones por fila o columna
rowMeans(M) # vector de medias de filas
colSums(M)  # vector de sumas de columnas
