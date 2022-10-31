median <- c(17.5, 17.7, 18.8, 20.8, 21.6, 23.0, 23.4, 24.6, 26.0, 27.2, 28.3, 28.9)
average <- c(25.8, 26.4, 28.2, 29.8, 30.7, 32.0, 32.8, 33.9, 35.4, 36.6, 37.6, 38.5) 
gini <- c(0.494, 0.506, 0.489, 0.475, 0.474, 0.465, 0.466, 0.46, 0.456, 0.446, 0.438, 0.44)
year <- 2009:2020
par(mfrow = c(1, 2))
plot(x = year, y = average, type = "b", pch = 17, col = "red", ylim = c(15, 40))
lines(x = year, y = median, type = "b", pch = 2, col = "blue")
plot(x = year, y = gini, type = "b", pch = 17, col = "red", ylim = c(0.2, 0.6))