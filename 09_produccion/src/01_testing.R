#################
# Luz Frias
# 2017-06-07
# testing automatizado con testthat
# https://github.com/hadley/testthat
# http://r-pkgs.had.co.nz/tests.html
#################

library(testthat)

# Imagina que eres el autor del paquete lubridate. Este paquete contiene utilidades de
#  manejo de fechas. Por ejemplo:

library(lubridate)
some_day <- ymd("20170605")
some_time <- ymd_hms("2017-06-05 14:00:30", tz = "Europe/London")
minute(some_time) <- 15
minute(some_time)
wday(some_time, label = TRUE)
ceiling_date(some_time, unit = "minute")
floor_date(some_time, unit = "day")

# Testing
test_that("ymd creates a valid date", {
  result <- ymd("20170305")
  expect_is(result, "Date")
  expect_equal(as.numeric(format(result, "%Y")), 2017)
  expect_equal(as.numeric(format(result, "%m")), 3)
  expect_equal(as.numeric(format(result, "%d")), 5)
})

# Ejercicio: rompe el test y mira qué pasa

# Hay más tipos de expect:
# - expect_equal: igualdad con tolerancia numérica
# - expect_identical: igualdad exacta. Probar expect_identical(1, 1 + 1e-9) y expect_equal(1, 1 + 1e-9)
# - expect_match: comprueba que una cadena está contenida en el resultado
# - expect_output: comprueba que una cadena está contenida en la salida. Se puede usar sin parámetros
#    para comprobar que se ha impreso algo
# - expect_message: similar, pero con los messages
# - expect_warning: ídem, con los warnings
# - expect_error: ídem com los errors
# - expect_is: comprueba si un objeto hereda de una clase
# - expect_true: comprueba que sea true
# - expect_false: comprueba que sea false

# Ejercicio:
# - Haz una función say_hi que devuelva "Hello" más el nombre indicado por parámetro y además
#    lo imprima por pantalla (con print)
# - Crea un test para ver que la función contiene "Hello" y también contiene el nombre introducido
# - Añade al test la comprobación de que se imprime por pantalla
# - Crea un test para comprobar que salta un warning al intentar calcular el log de un número negativo

