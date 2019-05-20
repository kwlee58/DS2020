roll_w <-
function() {
die <- 1:6
dice <- sample(die, size = 2, replace = TRUE, prob = c(rep(1/8, 5), 3/8))
sum(dice)
}
