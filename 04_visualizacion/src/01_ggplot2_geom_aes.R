#################
# Luz Frias
# 2016-11-08
# ggplot2
#################

library(ggplot2)

# Cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# Los datos: diamantes
dim(diamonds)
summary(diamonds)
?diamonds

# Primeras visualizaciones
ggplot(diamonds)

ggplot(data = diamonds) +
  geom_point(aes(x = price, y = carat))

# ¿Qué estamos haciendo?
# - Definimos los datos
# - Añadimos una capa, con geometría de puntos, donde:
#  - x: precio
#  - y: quilate

# Estilo base más elegante que los paquetes base
plot(diamonds$price, diamonds$carat)

# Un scatter plot
# Aesthetics
# Se comportan de manera diferente si el atributo es discreto o continuo
ggplot(data = diamonds, aes(x = price, y = carat)) +
  geom_point(aes(shape = cut, colour = color, size = x))
# Un poco recargado, ¿no? prueba a cambiar los aesthetics de variables continuas
#  por discretas y al revés, y observa el resultado
# ¿Qué pasa con los colores?

# Otras capas geométricas:
# - geom_point
# - geom_jitter
# - geom_line
# - geom_smooth
# ... referencia: cheatsheet

# Gráficos de barras
# La posición juega un papel muy importante para comparar diferentes atributos
ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar(position = "stack")
ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar(position = "dodge")
ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar(position = "fill")

# Histogramas
# Para representar la distribución de una variable
ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_histogram(binwidth = 1000)
# Algunos gráficos no requieren ninguna transformación estadística: los scatterplots
#  (de puntos) muestran x e y para cada muestra. En cambio, otros necesitan este tipo
#  de transformaciones: boxplots, histogramas, líneas de tendencia, ...
# En el caso de este histograma, le decimos la anchura de cada barra

# Ejercicio
# 1. Lee los datos del economista (EconomistData.csv), con indicadores de desarrollo
#  y corrupción por países
#  HDI: Human Development Index (1: más desarrollado)
#  CPI: Corruption Perception Index (10: menos corrupto)
# 2. Crea un gráfico que:
#  - Cada país sea un punto
#  - El eje x indique CPI, el y HDI
#  - El color del punto indique la región
#  - Su tamaño sea proporcional al ranking HDI
# 3. ¿Qué conclusiones extraes del gráfico?

