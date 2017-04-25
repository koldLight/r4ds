#################
# Luz Frias
# 2017-04-25
# sistemas de recomendación - reglas de asociación
# Basado en:
# http://www.salemmarafi.com/code/market-basket-analysis-with-r/
# https://rpubs.com/sbushmanov/180410
#################

library(arules)
library(arulesViz)
library(datasets)

# Reglas de asociación:
# - No es personalizada, es decir, no usa información sobre el usuario
# - El objetivo es encontrar ítems que se compran juntos. A => B
# - Útil cuando hay mucha oferta y las cestas son pequeñas
# - Caso de uso: análisis sobre el carrito de la compra en e-commerce

data("Groceries")

# Atención: Groceries no es un data.frame al uso
class(Groceries)
str(Groceries)

# En este caso ya lo tenemos cargado en el formato que necesita arules
#  Pero en la vida real, tendremos que convertir una tabla (CSV, registros de BD, ...)
#  a tipo transactions. Ver ?read.transactions y concretamente las diferentes entre el
#  formato basket o single.

summary(Groceries)

# Ejercicio: de la salida de summary, extrae los siguientes datos:
# - # total de transacciones
# - # total de productos diferentes
# - El producto que más se compra
# - # de transacciones con un solo producto
# - # de productos de la cesta más grande
# - # media y mediana de productos por cesta

# Productos
itemLabels(Groceries)[1:20]

# Gráficos de los productos más frecuentes
itemFrequencyPlot(Groceries, topN = 20, type = "absolute")
itemFrequencyPlot(Groceries, topN = 20, type = "relative")

# Nos interesan los productos que se suelen comprar juntos
ct <- crossTable(Groceries)
ct[1:7, 1:7]

# Ejercicio: muestra usando la matriz ct que acabamos de crear:
# - La cantidad de leche entera que se ha comprado
# - Las veces que leche entera y carne se han comprado juntas
# - Los 5 productos que son más y menos frecuentes que se compren junto a la leche entera

# Conceptos utilizados en el paquete arules:
# - count: número de ocurrencias de un producto o conjunto de productos en el dataset de transacciones.
#    P.e. para la leche entera es 2513
# - support: número de ocurrencias en un producto o conjunto de productos dividido entre el número de
#    transacciones. P.e. para la leche entera es 2515 / 9835 = 0.26
# - confidence {A} => {B}. Es P(B|A). La probabilidad de que se compre B conociendo que se ha comprado
#    A. Para realizar buenas recomendaciones, buscamos valores altos
# - lift: P(AB) / (P(A) * P(B)). Representa "cuánto más" aparece una regla en cuestión comparándolo
#    con eventos por puro azar. Un valor de 1 representa que los productos son independientes entre sí.
#    Buscaremos valores altos para hacer buenas recomendaciones
# - chiSquared: test estadístico que nos da una medida indicando si A y B son dependientes. Se
#    interpreta como el p-valor de las regresiones lineales. Valores bajos (típicamente < 0.05) se
#    dan cuando A y B son dependientes. Útil en casos en los que el lift es cercano a 1 pero count es
#    alto, o cuando lift es significativamente diferente a 1 pero el count es bajo.

crossTable(Groceries, measure = "lift", sort = TRUE)[1:7, 1:7]

# Ejercicio: interpreta la dependencia de la leche entera con otros productos populares, mirando
#  el resultado anterior. ¿Qué pasa con los refrescos?

# apriori: busca conjuntos de productos frecuentes
# Muy potente, admite mucha personalización:
# - dos aproximaciones posibles:
#   1. extraer conjuntos de productos 
#   2. extraer reglas de asociación
# - configurar min y max (si tiene sentido) de tamaños de conjuntos de productos, support, confidence 
#    y lift
# - enfocarlo a un determinado producto

# apriori para conjuntos de productos: target = "frequent itemsets"
itemsets <- apriori(Groceries, parameter = list(support = .001, 
                                                minlen = 2, 
                                                target = "frequent"))
summary(itemsets)

# Podemos utilizar las funciones:
# - inspect: imprime en formato amigable reglas o conjuntos de productos
# - sort: ordena por lo especificado en by. Las diferentes medidas se pueden extraer con
#    la función interestMeasure
inspect(sort(itemsets, by = "support", decreasing = TRUE)[1:7])

# Ejercicio: muestra los conjuntos de productos con mayor lift. ¿Qué pasa?

# Si queremos agregar el lift, se haría así:
quality(itemsets)$lift <- interestMeasure(itemsets, measure = "lift", Groceries)

# Ejercicio: repite el último ejercicio!

# Ejercicio: construye conjuntos de elementos de longitud 2 (ni más ni menos) y examina las 10
#  parejas de productos con mayor lift (probabilidad de aparecer juntas frente a sus frecuencias)

# apriori: busca conjuntos de reglas. target = "rules"
rules <- apriori(Groceries, parameter = list(support = .001,
                                             confidence = .7,
                                             minlen = 2,
                                             target = "rules"))
summary(rules)

# Igual que con los conjuntos de productos, podemos examinar las reglas con inspect + sort
inspect(sort(rules, by = "lift", decreasing = TRUE)[1:5])

# Ejercicio: agrega la medida de chi-squared en forma de p-valor para tener una medida aproximada de la probabilidad
#  de que la correlación destacada sea producida por sucesos aleatorios. Pista: ?interestMeasure
#  Luego, vuelve a observar los resultados con mayor lift. ¿Que conclusiones extraes?

# Podemos explorar las reglas que contengan ciertos productos, con subset. Argumentos importantes:
# - lhs: left hand side (antecedente)
# - rhs: right hand side (consecuencia)
# - items: productos en cualquier lado, lhs o rhs
# - %in%: coincide cualquiera
# - %ain%: coinciden todos
# - %pin%: coincide parcialmente. P.e. si ponemos "meat", coincide con "hamburger meat", "pork meat", ...
# - &: restricciones adicionales

# Ejemplo de uso de subset: vamos a buscar reglas en las que estén presentes la leche entera y el yogurt y el valor de
#  confidence sea al menos de un 95%

inspect(subset(rules, subset = items %ain% c("whole milk", "yogurt") & confidence > .95))

# Ejercicio: busca aquellas reglas que tengan leche entera y yogurt en el antecedente y confidence sea al menos del 90%

# Ejercicio: busca reglas que tengan cualquier tipo de pan como antecedente y leche entera como consecuencia

# Ejercicio: vamos a buscar productos complementarios. Es decir, aquellos que raramente ocurren juntos.
# 1. Cita algunos ejemplos que puedan cumplir estas características.
# 2. Construye un set de reglas de parejas (1 producto => 1 producto) con un valor de confidence suficientemente bajo
#     como para ver este fenómeno (sugerencia 0.01)
# 3. Agrega la medida del test estadístico de chi-square en forma de p-valor, para distinguir significancia de azar
# 4. Compara los productos de diferentes tipos de cerveza
# 5. Comprueba en crossTable(Groceries) la frecuencia a la vez y por separado de los tipos de cerveza
# 6. Interpreta el valor de confidence y de lift de la regla que relaciona los dos tipos de cerveza entre sí

# Visualización
plot(rules, interactive = FALSE)
