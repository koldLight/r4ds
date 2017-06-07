#################
# Luz Frias
# 2017-06-07
# creación de paquetes en R
#################

library(devtools)
library(roxygen2)

# Para crear la estructura del paquete R
create("examplepackage")

# Ejercicio:
# - Examina los ficheros creados. ¿Para qué sirven DESCRIPTION y NAMESPACE?
# - Crea un fichero en R/ con una función que salude llamada say_hi
# - Añade documentación a tu función. Puedes generarla manualmente o, más cómodo, hacerlo
#    "a lo javadoc". Mira aquí como hacerlo: https://github.com/klutometis/roxygen#roxygen2

# Convierte la documentación en el formato necesario para paquetes de R (y más cosas que ahora
#  no nos interesan)
document("examplepackage")

# Ya puedes generar tu paquete de R. Desde línea de comandos, haz:
# R CMD build examplepackage
# R CMD check examplepackage_<version>.tar.gz

# Si el R CMD check te da errores o warnings, corrígelos y prueba a hacerlo de nuevo

# Después, puedes instalar tu paquete con:
install.packages("examplepackage_0.0.0.9000.tar.gz", repos = NULL)
library(examplepackage)
?say_hi
say_hi("asd")
remove.packages("examplepackage")

# Ejercicio: crea un paquete que sea instalable desde un repositorio de tu github
