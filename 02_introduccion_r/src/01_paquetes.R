#################
# Luz Frias
# 2016-10-10
# Paquetes
#################

# Paquetes instalados
library()

# Paquetes cargados
(.packages())

# Instalar un paquete
install.packages("reshape2")

# Actualizarlo
update.packages("reshape2")

# Cargarlo
library(reshape2)

# devtools: para instalar paquetes de fuera de CRAN

# Ejercicio: 
# 1. Instala desde CRAN el paquete devtools
# 2. Utilizando devtools instala el siguiente paquete:
# https://github.com/cjgb/caRtociudad
# 3. Cárgalo y ejecuta algún ejemplo disponible en el readme del paquete. E.g.:
# cartociudad_reverse_geocode(40.45332, -3.69442)
# 4. Elimínalo
# Pistas:
# ?install_github
# ?remove.packages
