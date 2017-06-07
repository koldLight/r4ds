#################
# Luz Frias
# 2017-06-07
# gestión de dependencias en R
# https://rstudio.github.io/packrat/
#################

# En la carpeta del proyecto, inicializamos el entorno
# Esto escanea el directorio actual y se descarga los paquetes necesarios
# Antes de hacer esto, comprueba que tienes el working directory en la ruta de este script
packrat::init(".")

# Para comprobar el estado
packrat::status()

# Nueva librería
install.packages("reshape2")

# Para guardar los paquetes que se utilizan actualmente
packrat::snapshot()

# Hay que ignorar packrat/lib*/ en el .gitignore

# Para restaurar los paquetes
packrat::restore()
