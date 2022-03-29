play <- function(a,b) {
  a <- c(0.4, 0.3, 0.3)
  b <- c(0.1, 0.8, 0.1)
  
  A <- sample(1:3, 1, prob = a)
  B <- sample(1:3, 1, prob = b)
  
  if (A == B) {
    R <- "A Win"
  } else {R <- "B Win"}
  
  R
}

play()




