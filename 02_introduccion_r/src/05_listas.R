#################
# Luz Frias
# 2016-10-10
# Listas
#################

# Generación
a <- list("a", TRUE, 4)
direccion <- list(calle = "General Perón", numero = 27, ciudad = "Madrid")
c(a, direccion)     # concatena
list(a, direccion)  # anida
as.list(1:5)

# Exploración
length(a)
names(direccion)

# Indexación y [ frente a [[
direccion[1]
direccion[["calle"]]
direccion$calle
mode(direccion[1])
mode(direccion[[1]])

# Operaciones a los elementos
lapply(direccion, toupper) # lista
sapply(direccion, toupper) # "simplificado": vector
Reduce(paste, direccion)
