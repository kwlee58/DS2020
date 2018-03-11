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
roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2(bones = 1:4)
roll2(bones = 1:5)
roll2(1:20)
# roll2()
## Default Value
roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
ls()
# dump
dump(list = c("roll", "roll2"), file = "./roll.R")
