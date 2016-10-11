#################
# Luz Frias
# 2016-10-10
# Factors
#################

# Generación
a <- c("GOOD", "BAD", "BAD", "BAD", "GOOD")
a_f <- factor(a)
as.character(a_f)

# Generación con orden
b <- c("pais", "pais", "ciudad", "continente", "ciudad")
b_levels <- c("ciudad", "pais", "continente")
b_f <- factor(b, levels = b_levels, ordered = TRUE)

# Inspección
levels(b_f)

# Añadir un nivel
levels(b_f) <- c(levels(b_f), "mundo")

# Eliminar niveles no utilizados
b_f <- b_f[drop = TRUE]
