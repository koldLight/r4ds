#################
# Luz Frias
# 2016-11-08
# ggplot2
#################

library(ggplot2)
library(scales)

# Cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# Cambio de escalas en los ejes
# Podemos modificar las escalas de x e y
# Por ejemplo, con escalas logarítmicas
ggplot(data = diamonds, aes(x = price, y = carat)) +
  geom_point(aes(colour = color)) +
  scale_x_log10()

# Cambio del sistema de coordenadas
# A polares, por ejemplo
ggplot(data = diamonds, aes(x = price, y = carat)) +
  geom_point(aes(colour = color)) +
  coord_polar()

# Etiquetas en las escalas
ggplot(data = diamonds, aes(x = price, y = carat)) +
  geom_point(aes(colour = color)) +
  scale_x_continuous(name = "Precio") +
  scale_y_continuous(name = "Quilates") +
  scale_color_discrete(name = "Color")

# Escalas de colores
# Un ejemplo continuo
d <- diamonds[sample(nrow(diamonds), 1000), ]
ggplot(data = d, aes(x = cut, y = price)) +
  geom_jitter(aes(colour = price)) +
  scale_color_continuous(name="",
                         breaks = c(500, 4000, 18000),
                         labels = c("barato", "razonable", "muy caro"),
                         low = "green", high = "red")

# Un ejemplo de escala de colores discreta
# ¿Nunca atinas con los colores? Usa colorbrewer! http://colorbrewer2.org/
ggplot(d, aes(carat, price)) +
  geom_point(aes(colour = clarity)) +
  scale_colour_brewer(palette = "Greens")

# Facet grid
# genera una matriz de gráficos, muy útil para observar la distribución
#  de una variable en base a otras dos
ggplot(diamonds, aes(x = clarity, fill = cut)) +
  geom_bar(show.legend = FALSE) +
  facet_grid(cut ~ color)

# por defecto, respetan la misma escala de x e y, a no ser que le indiquemos lo contrario
ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar(show.legend = FALSE) +
  facet_grid(cut ~ color, scales = "free_y")

# Facet wrap
# como el facet_grid pero en lugar de crear los gráficos en forma de matriz, lo hace
#  secuencialmente
ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar(show.legend = FALSE) +
  facet_wrap(cut ~ color, scales = "free_y", ncol = 6)

# Ejercicio
# 1. Lee los datos del economista (EconomistData.csv), con indicadores de desarrollo
#  y corrupción por países
# 2. Crea un gráfico que:
#  - Cada país sea un punto
#  - El eje x indique CPI y se llame "Corruption Perception Index"
#  - El eje y indique HPI y se llame "Human Development Index"
#  - El color del punto indique la región, y la leyenda se titule "Region of the world"
#  - Los colores de regiones sean los siguientes: #24576D, #099DD7, #28AADC, #248E84, 
#     #F2583F, #96503F. Pista: ?scale_color_manual

# Ejercicio
# 1. Examina los datos de mpg
# 2. Crea un gráfico como este: res/drv_model.png
# para ajustar los textos, mira theme(strip.text = ...) y los argumentos de element_text
