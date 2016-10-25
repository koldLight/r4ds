#################
# Luz Frias
# 2016-10-25
# BDs y SQL
#################

# Ejemplo con SQLite
# Instalación en local:
# https://www.tutorialspoint.com/sqlite/sqlite_installation.htm

library("sqldf")

# Establecemos conexión
file.create("test.db") # una base de datos vacía
con <- dbConnect(SQLite(), dbname="test.db")

# Creación de tablas
dbWriteTable(con, "state", as.data.frame(state.x77))

# Inspección de tablas
dbListTables(con)
dbListFields(con, "state")

# Queries escritura (delete, update, insert, create table, ...)
dbSendQuery(con, "delete from state where row_names = 'Maine'")

# Queries lectura (select)
dbGetQuery(con, "select row_names, Income from state where Income < 3800")

dbGetQuery(con, "select row_names
                 from state s1, 
                   (select max(Income) maxIncome from state) s2
                 where s1.Income = s2.maxIncome")

# Drop tabla
dbRemoveTable(con, "state")
