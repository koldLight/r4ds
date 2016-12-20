#################
# Luz Frias
# 2016-12-20
# highcharter - Gráficos interactivos
#################

# Para esto, no utilizamos ggplot2. En su lugar, utilizamos highcharter
library(highcharter)
library(dplyr)

# Cogemos un subconjunto de los diamantes para visualizar
set.seed(1234)
data <- sample_n(diamonds, 300)
data$color <- NULL

# Scatterplot
hchart(data, "scatter", x = carat, y = price, group = cut, size = z)

# Gráfico de barras con los datos de coches (mpg), conteo por fabricante y año
mpg.count.year <- count(mpg, manufacturer, year)
hchart(mpg.count.year, "column", x = manufacturer, y = n, group = year)
# prueba a cambiar "column" por "bar"

# Heatmap con los datos de coches, conteo por fabricante y tipo
mpg.count.class <- count(mpg, manufacturer, class)
hchart(mpg.count.class, "heatmap", x = manufacturer, y = class, value = n)
