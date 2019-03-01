# S3 
## Data
load("./Programs.RData")
play()
one_play <- play()
one_play
## S3 System
num <- 1000000000
print(num)
class(num) <- c("POSIXct", "POSIXt")
print(num)
## Attributes
load("./Environments.RData")
attributes(DECK)
row.names(DECK)
row.names(DECK) <- 101:152
levels(DECK) <- c("level 1", "level 2", "level 3")
attributes(DECK)
attributes(one_play)
attr(one_play, "symbols") <- c("B", "0", "B")
attributes(one_play)
one_play
one_play + 1
play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}
play()
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
three_play <- play()
three_play
attr(three_play, "symbols")
slot_display <- function(prize) {
  symbols <- attr(prize, "symbols")
  symbols <- paste(symbols, collapse = " ")
  string <- paste(symbols, prize, sep = "\n$")
  cat(string)
}
one_play
attr(one_play, "symbols")
symbols <- attr(one_play, "symbols")
symbols
paste(symbols, collapse = " ")
symbols <- paste(symbols, collapse = " ")
symbols
paste(symbols, one_play, sep = "\n$")
string <- paste(symbols, one_play, sep = "\n$")
string
cat(string)
slot_display(one_play)
slot_display(three_play)
slot_display(play())
replicate(20, slot_display(play()))
##### cat()의 도움말을 살펴보고 대책을 강구하자.
slot_display <- function(prize) {
  symbols <- attr(prize, "symbols")
  symbols <- paste(symbols, collapse = " ")
  string <- paste(symbols, prize, sep = "\n$")
  cat(string, sep = "\n")
}
paste("$", one_play, sep = "")
slot_display(play())
replicate(20, slot_display(play()))
## Generic Functions
print(pi)
pi
print(head(DECK))
head(DECK)
print(play())
play()
num <- 1000000000
class(num)
print(num)
class(num) <- c("POSIXct", "POSIXt")
print(num)
num
print(unclass(num))
## Methods
print
num.f <- factor(c(1:3, 3:1), levels = 1:3, labels = c("A", "B", "C"))
num.f
class(num.f)
str(num.f)
methods(print)
## Method Dispatch
print.function
summary.matrix
class(one_play) <- "slots"
one_play
args(print)
print.slots <- function(x, ...) {
  cat("I'm using the print.slots method")
}
print(one_play)
one_play
rm("print.slots")
now <- Sys.time()
attributes(now)
print.slots <- function(x, ...) {
  slot_display(x)
}
one_play
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}
class(play())
play()
play()
## Classes
methods(class = "factor")
play1 <- play()
play1
play2 <- play()
play2
c(play1, play2)
play1[1]
save.image("./S3.RData")
