#################
# Luz Frias
# 2017-04-25
# sistemas de recomendación - filtrado colaborativo
# datos: https://grouplens.org/datasets/movielens/100k/
#################

library(dplyr)

# Filtrado colaborativo
# - Está personalizado, es decir, usa información del usuario
# - Dos enfoques: user-based y item-based
# - Busca usuarios / items similares
# - Casos de uso: recomendación en películas al estilo netflix

# Concepto importante: distancia entre usuarios / items
# Normalmente se utiliza la correlación por parejas (entre usuario1 y usuario2, usuario1 y usuario3, ...)
# Con la correlación, hay que tener cuidado con los nulos. Posible solución: eliminarlos. En este caso, hay que
#  tener en cuenta la cantidad de elementos no nulos por ambas partes.

# Usamos los datos de movielens
ratings <- read.table("../dat/u.data", sep = "\t")[, 1:3]
films   <- read.table("../dat/u.item", sep = "|", quote = "", header = FALSE)[, 1:2]
colnames(ratings) <- c("user", "film", "rating")
names(films)      <- c("film", "name")
head(ratings)
head(films)

# Vamos a hacer el proceso para un usuario concreto
# Elijamos uno que tenga bastantes ratings
tail(sort(table(ratings$user)), 100)   # Ejercicio: ¿por qué es útil el tail(sort(table(x)))?
user <- 244

# Calculamos su correlación con respecto a otros usuarios
ratings_user   <- ratings[ratings$user == user, ]
ratings_others <- ratings[ratings$user != user, ]

ratings_common <- merge(ratings_user, ratings_others, by = "film")  # Estamos "eliminando los nulos" para cor
user_affinity  <- ratings_common %>%
  group_by(user.y) %>%
  summarize(common = n(),
            corr = cor(rating.x, rating.y))
colnames(user_affinity)[1] <- "user"

# Paréntesis: aclaración sobre cómo funciona cor:
cor(c(1, 2, 3, 4), c(1, 2, 3, 4))
cor(c(1, 2, 3, 4), c(4, 3, 2, 1))
cor(c(1, 2, 3, 4), c(1, 2, 2, 1))
cor(c(10, 20, 30, 40), c(1, 2, 3, 4))
cor(c(2, 2, 2, 2), c(1, 2, 3, 4))

# Seguimos: usuarios más y menos afines a nuestro user
# Primero, aseguramos que al menos hayan valorado un mínimo de películas en común
user_affinity <- user_affinity[user_affinity$common >= 5, ]
# Luego, podemos sacar usuarios más y menos afines
user_affinity %>% arrange(desc(corr))  # almas gemelas de user
user_affinity %>% arrange(corr)        # user nunca iría al cine con estos

# Utilizamos esta información para recomendar. Un posible criterio: recomendar películas que los usuarios más
#  afines hayan valorado con un 5, y que el usuario en cuestión todavía no haya visto
# 1. Cogemos los ratings de otros usuarios sobre las películas que no ha visto
user_seen_films      <- ratings_user$film
user_unseen_ratings  <- ratings_others[!(ratings_others$film %in% user_seen_films), ]
# 2. Lo cruzamos con la afinidad que hemos calculado con cada usuario
user_unseen_affinity <- merge(user_unseen_ratings, user_affinity, by = "user")
# 3. Cogemos aquellos ratings con puntuación máxima (5)
user_unseen_affinity <- user_unseen_affinity[user_unseen_affinity$rating == 5, ]
# 4. Ordenamos el resultado de mayor a menor afinidad
user_unseen_affinity <- user_unseen_affinity %>% arrange(desc(corr))
# 5. Unos títulos a recomendar, p.e., serían
recommendation <- merge(user_unseen_affinity[1:5, ], films, by = "film")
recommendation

# Ejercicio: hemos hecho un filtrado colaborativo en base a usuarios. Ahora, haz tú uno basado en
#  items. Para ver si funciona correctamente, saca las películas más parecidas a una que conozcas,
#  y evalúa el resultado

# Ejercicio: ¿qué pasa con las valoraciones de cada usuario? Piensa en su objetividad. ¿Podemos hacer
#  algo para mejorarlo?

# Ejercicio: prueba recomendaciones contigo mismo, es decir, puntúa alrededor de 10 películas que
#  hayas visto y prueba qué te sugiere tu motor de recomendación. ¿Son buenas?

