#################
# Luz Frias
# 2017-04-25
# Lectura de google spreadsheets en Drive
# Doc del paquete en github:
# https://github.com/jennybc/googlesheets
#################

library(googlesheets)

# Autenticación interactiva en Google
# https://github.com/jennybc/googlesheets/blob/master/vignettes/managing-auth-tokens.md
token <- gs_auth()

# Podemos guardar el token si necesitamos que el script no sea interactivo
saveRDS(token, file = "googlesheets_token.rds")

# De esta forma, lo podremos recuperar al principio de nuestro script
gs_auth(token = "googlesheets_token.rds")

# Búsqueda de hojas
gs_ls("iris")

# Necesitamos "registrarla" antes de poder usarla. Para ello, necesitamos el título, la url
g_iris <- gs_title("iris")
g_iris_data <- gs_read(g_iris)
g_iris_data

# Podemos también descargarlo en formato csv
gs_download(g_iris, to = "g_iris.csv")

# Comprobamos que sea correcto
g_iris_data_copy <- read.csv("g_iris.csv")
head(g_iris_data_copy)
