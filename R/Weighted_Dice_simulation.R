# Simulation
source("./roll.R")
ls()
replicate(20, roll())
N <- 10000
rolls <- replicate(N, roll())
table(rolls)
options("digits")
options(digits = 2)
table(rolls)/N
table(rolls)/N * 36
options(digits = 1)
table(rolls)/N * 36
options(digits = 7)
# histogram
library(ggplot2)
qplot(c(1, 2, 2, 2, 3, 3), binwidth = 1)
qplot(c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4), binwidth = 1)
qplot(rolls, binwidth = 1)
# Weighted Dice
roll.w <- roll
fix(roll.w)
roll.w
replicate(20, roll.w())
N <- 10000
rolls.w <- replicate(N, roll.w())
table(rolls.w)
options("digits")
options(digits = 2)
table(rolls.w)/N
table(rolls.w)/N * 64
options(digits = 1)
table(rolls.w)/N * 64
# histogram
qplot(rolls.w, binwidth = 1)
# dump
dump(list = "roll.w", file = "./roll_w.R")
