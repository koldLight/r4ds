library(reshape2)
library(ggplot2)

AIR_DATA_FORMAT <- c(
  station     = 8,
  variable    = 2,
  technique   = 2,
  periodicity = 2,
  year        = 2,
  month       = 2,
  day         = 2,
  value       = rep(6, 24)
)

# Leemos formato de ancho fijo
widths <-AIR_DATA_FORMAT
data <- read.fwf("dat/feb_mo17.txt", widths, stringsAsFactors = FALSE)
colnames(data) <- names(widths)

# Pasamos de formato ancho a formato largo
data.melted <- melt(data, id.vars = c("station", "variable", "technique", "periodicity", "year", "month", "day"),
                    variable.name = "hour")

# Extraemos la hora
data.melted$hour <- as.numeric(gsub("value([0-9]+)$",
                                    "\\1",
                                    as.character(data.melted$hour))) - 1

# Pasamos año, mes, día y hora, a fecha
data.melted$date <- strptime(paste0(data.melted$year, "/", data.melted$month, "/", data.melted$day, " ", 
                                    data.melted$hour), format = "%y/%m/%d %H")
head(data.melted$date)

# Separamos el valor en el valor en sí + si es válido o no
data.melted$is_valid <- substr(data.melted$value, 6, 6)
data.melted$value <- as.numeric(substr(data.melted$value, 1, 5))

# Filtramos para tener solo NO2 y valores válidos
data.melted <- data.melted[data.melted$variable == 8, ]
data.melted <- data.melted[data.melted$is_valid == "V", ]

# Eliminamos las columnas que no sirven
data.melted[, c("variable", "technique", "periodicity", "year", "month", "day", "hour")] <- NULL

# Cruzamos con la información de estaciones
stations <- read.csv("dat/stations.tsv", sep = "\t", stringsAsFactors = FALSE)
cont <- merge(data.melted, stations)

# Pintamos
ggplot(cont, aes(date, value)) +
  geom_line(aes(color = name)) +
  facet_wrap(~ area, ncol= 1)
