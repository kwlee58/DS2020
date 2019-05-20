# Objects
die <- 1:6
die
ls()
die - 1
die / 2
die * die
1:2
1:4
die + 1:2
die + 1:4
die %*% die
die %o% die
outer(die, die)
help("%*%")
help("%o%")
?`%*%`
?outer
# Functions
round(3.1415)
round(3.1415, digits = 2)
factorial(3)
mean(1:6)
mean(die)
sd(die)
round(mean(die))
?sample
sample(x = 1:4, size = 2)
sample(x = die, size = 1)
sample(x = die, size = 1)
sample(x = die, size = 1)
sample(die, size = 1)
round(3.1415, corners = 2)
args(round)
round(3.1415, digits = 2)
sample(die, 1)
sample(size = 1, x = die)
?sample
# Sample with Replacement
sample(die, size = 2)
sample(die, size = 2, replace = TRUE)
sample(die, size = 2, replace = TRUE)
dice <- sample(die, size = 2, replace = TRUE)
dice
sum(dice)
# Writing Your Own Functions
## The Function Constructor
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}
roll()
roll
## Arguments
roll2(bones = 1:4)
roll2(bones = 1:5)
roll2(1:20)
roll2()
## Default Value
roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
ls()
dump(list = c("roll", "roll2"), file = "./roll.R")
ls()
list.files()
rm(list = ls())
ls()
source("./roll.R")
ls()
roll()
roll2(bones = 1:5)
roll2()
