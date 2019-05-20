sink(file = "../docs/Programs_out.txt")
# Programs
## Intro
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE, 
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}
get_symbols()
table(replicate(1000, get_symbols()))
table(replicate(1000, get_symbols()))/3000
##### 표준오차는 1%
round(table(replicate(1000, get_symbols()))/3000, digits = 2)
round(table(replicate(10000, get_symbols()))/30000, digits = 2)
## Strategy
### Sequential Steps
### Parallel Cases
### if Statements
# num <- -2
num <- 4
if (num < 0) {
  num <- num * -1
}
num
all(c(TRUE, FALSE))
any(c(TRUE, FALSE))
num <- -1
if (num < 0) {
  print("num is negative.")
  print("Don't worry, I'll fix it.")
  num <- num * -1
  print("Now num is positive.")
}
num
x <- -1
if (3 == 3){
  x <- 2
}
x
x <- 1
if (TRUE) {
  x <- 2
}
x
x <- 1
if (x == 1) {
  x <- 2
  if (x == 1) {
    x <- 3
  } 
}
x
### else Statements
pi
a <- pi
dec <- a - trunc(pi)
dec
if(dec >= 0.5) {
  a <- trunc(a) + 1
} else {
  a <- trunc(a)
}
a
a <- 2
b <- 2
if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}
### Test whether the symbols are three of a kind
symbols <- c("7", "7", "7")
symbols[1] == symbols[2] & symbols[2] == symbols[3]
symbols == symbols[1]
all(symbols == symbols[1])
unique(symbols)
length(unique(symbols))
length(unique(symbols)) == 1
symbols <- c("B", "BBB", "BB")
symbols %in% c("B", "BB", "BBB")
symbols <- c("B", "BBB", "B")
symbols %in% c("B", "BB", "BBB")
match(symbols, c("B", "BB", "BBB"))
all(symbols %in% c("B", "BB", "BBB"))
same <- length(unique(symbols)) == 1
bars <- symbols %in% c("B", "BB", "BBB")
all(bars)
symbols <- rep("B", 3)
bars <- symbols %in% c("B", "BB", "BBB")
all(bars)
### Lookup Tables
payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
payouts
payouts["DD"]
payouts["B"]
unname(payouts["B"])
prize <- unname(payouts[symbols[1]])
prize
same <- length(unique(symbols)) == 1
bars <- symbols %in% c("B", "BB", "BBB")
if(same) {
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize <- unname(payouts[symbols[1]])
} else if (all(bars)) {
  prize <- 5
} else {
}
symbols <- c("C", "DD", "C")
symbols == "C"
sum(symbols == "C")
sum(symbols == "DD")
same <- length(unique(symbols)) == 1
bars <- symbols %in% c("B", "BB", "BBB")
if(same) {
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize <- unname(payouts[symbols[1]])
} else if (all(bars)) {
  prize <- 5
} else {
  cherries <- sum(symbols == "C")
  prize <- c(0, 2, 5)[cherries + 1]
}
diamonds <- sum(symbols == "DD")
cherries
cherries + 1
prize <- prize * 2 ^ diamonds
prize
## Code Comments
score <- function(symbols) {
  same <- length(unique(symbols)) == 1
  bars <- symbols %in% c("B", "BB", "BBB")
  if(same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
    prize <- 5
  } else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}
play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}
play()
play()
play()
play()
replicate(100, play())
ls()
sink()
play()
one_play <- play()
one_play
save.image(file = "./Programs.RData")
