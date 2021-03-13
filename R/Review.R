# Objects
die <- 1:6
die + 1
die + 1:2
die + 1:3
die + 1:4
die * die
die ^ 2
die ** 2
die / die
die %% 2
die %/% 2
die %*% die
die %o% die
outer(die, die)
help(%*%)
help("%*%")
help(`%*%`)
?`%*%`
?"%*%"
"%%"(die, 2)
`%%`(die, 2)
## Functions
round(3.1415)
round(3.1415, digits = 2)
factorial(3)
mean(1:6)
mean(die)
sd(die)
round(mean(die))
sample(x = 1:4, size = 2)
## Sample with Replacement
sample(die, size = 2)
sample(die, size = 2, replace = TRUE)
sample(6, size = 2, replace = TRUE)
sample(size = 2, die, replace = TRUE)
sample(2, die, replace = TRUE)
dice <- sample(die, size = 2, replace = TRUE)
dice
sum(dice)
## Writing Your Own Functions
### The Function Constructor
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}
roll()
roll
### Arguments
roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2(bones = 1:4)
roll2(bones = 1:5)
roll2(1:20)
roll2()
### Default Value
roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
ls()
## dump
dump(list = c("roll", "roll2"), file = "./roll.R")
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
## histogram
library(ggplot2)
qplot(c(1, 2, 2, 2, 3, 3), binwidth = 1)
qplot(c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4), binwidth = 1)
qplot(rolls, binwidth = 1)
## Weighted Dice
roll.w <- roll ; fix(roll.w)
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
## histogram
qplot(rolls.w, binwidth = 1)
## dump
dump(list = "roll.w", file = "./roll_w.R")
# R Objects
## Atomic Vectors
die <- 1:6
is.vector(die)
five <- 5
is.vector(five)
length(five)
length(die)
int <- 1L
text <- "ace"
int <- c(1L, 5L)
text <- c("ace", "hearts")
sum(int)
sum(text)
## Doubles
die <- 1:6
typeof(die)
## Integers
int <- c(-1L, 2L, 4L)
typeof(int)
pi
sqrt(2)^2 - 2
## Characters
text <- c("Hello", "World")
text
typeof(text)
typeof("Hello")
## Logicals
3 > 2
logic <- c(TRUE, FALSE, TRUE)
logic
typeof(logic)
typeof(F)
## Complex and Raw
comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp
typeof(comp)
raw(3)
typeof(raw(3))
hand <- c("ace", "king", "queen", "jack", "ten")
hand
typeof(hand)
## Attributes
attributes(die)
## Names
names(die)
names(die) <- c("one", "two", "three", "four", "five", "six")
die
names(die)
attributes(die)
names(die) <- ""
names(die) <- NA
names(die) <- NaN
names(die) <- NULL
## Dim
dim(die) <- c(2, 3)
die
dim(die) <- 1:3
die
attributes(die)
## Matrices
m <- matrix(die, nrow = 2)
m
m <- matrix(die, nrow = 2, byrow = TRUE)
m
## Arrays
ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))
ar
## Class
dim(die) <- c(2, 3)
typeof(die)
class(die)
attributes(die)
class("Hello")
class(5)
## Dates and Times
today <- Sys.Date()
now <- Sys.time()
now
typeof(today)
typeof(now)
class(today)
class(now)
unclass(now)
mil <- 1000000
mil
class(mil) <- c("POSIXct", "POSIXt")
mil
## Factors
gender <- factor(c("male", "female", "female", "male"))
typeof(gender)
class(gender)
attributes(gender)
unclass(gender)
gender
as.character(gender)
gender2 <- factor(c("male", "female", "female", "male"), 
                  levels = c("male", "female"),
                  labels = c("M", "F"))
str(gender2)
## Coercion
card <- c("ace", "hearts", 1)
card
str(card)
sum(c(TRUE, TRUE, FALSE, FALSE))
as.character(1)
as.logical(1)
as.numeric(FALSE)
## Lists
list1 <- list(100:130, "R", list(TRUE, FALSE))
list1
attributes(list1)
list2 <- list(number = 100:130, 
              char = "R", 
              logical = list(TRUE, FALSE))
list2
attributes(list2)
## Data Frames
df1 <- data.frame(c("ace", "two", "six"), 
                  rep("clubs", 3 ), 
                  c(1, 2, 6))
df1
str(df1)
df <- data.frame(face = c("ace", "two", "six"), 
                 suit = rep("clubs", 3), 
                 value = c(1, 2, 6))
df
str(df)
face <- c("ace", "two", "six")
suit <- rep("clubs", 3)
value <- c(1, 2, 6)
str(face)
df2 <- data.frame(face, suit, value)
str(df2)
df2 <- data.frame(face, suit, value, 
                  stringsAsFactors = FALSE)
df2
str(df2)
df3 <- data.frame(Face = face, Suit = suit, Value = value)
df3
str(df3)
typeof(df)
class(df)
attributes(df)
str(df)
df <- data.frame(face = c("ace", "two", "six"),
                 suit = c("clubs", "clubs", "clubs"),
                 value = c(1, 2, 6),
                 stringsAsFactors = FALSE)
str(df)
## from URL
url1 <- "https://gist.githubusercontent.com/garrettgman/9629323/raw/ee5dfc039fd581cb467cc69c226ea2524913c3d8/deck.csv"
deck <- read.csv(url1)
str(deck)
head(deck)
tail(deck)
deck <- read.csv("https://gist.githubusercontent.com/garrettgman/9629323/raw/ee5dfc039fd581cb467cc69c226ea2524913c3d8/deck.csv",
                 stringsAsFactors = FALSE)
str(deck)
write.csv(deck, file = "../data/cards.csv")
write.csv(deck, file = "../data/cards.csv", 
          row.names = FALSE)
ls()
save(list = ls(), file = "./r_objects.RData")
rm(list = ls())
ls()
load("./r_objects.RData")
ls()
rm(list = ls())
# R Notation
## read.csv
read.csv("../data/cards.csv")
deck <- read.csv("../data/cards.csv")
str(deck)
deck <- read.csv("../data/cards.csv", 
                 stringsAsFactors = FALSE)
str(deck)
head(deck)
## Positive Integers
deck[1, 1]
deck[1, 1:3]
new <- deck[1, 1:3]
new
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]
vec[c(2, 4, 6)]
str(deck[1, 1])
str(deck[1, 1, drop = FALSE])
str(deck[1, 1:3])
str(deck[1:3, 1])
str(deck[1:3, 1, drop = FALSE])
## Negative Integers
deck[-1, 1:3]
deck[-(2:52), 1:3]
## Blank Spaces
deck[1, ]
deck[ , 1]
deck[ , 1, drop = FALSE]
## Logical Values
deck[1, c(TRUE, TRUE, FALSE)]
rows <- c(TRUE, rep(FALSE, 51))
deck[rows, ]
## Names
deck[1, c("face", "suit", "value")]
deck[ , "value"]
deck[ , "value", drop = FALSE]
deal <- function(cards) { 
  cards[1, ]
}
deal(deck)
deck2 <- deck[1:52, ]
head(deck2)
deck2 <- deck[52:1, ]
head(deck2)
deck3 <- deck[c(2, 1, 3:52), ]
head(deck3)
random <- sample(1:52, size = 52)
random
deck4 <- deck[random, ]
head(deck4)
shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}
deal(deck)
deck2 <- shuffle(deck)
deal(deck2)
## Dollar Signs and Double Brackets
str(deck)
deck$value
mean(deck$value)
median(deck$value)
lst <- list(numbers = c(1, 2), 
            logical = TRUE, 
            strings = c("a", "b", "c"))
lst
lst[1]
lst$numbers
lst[[1]]
lst["numbers"]
lst[["numbers"]]
# R Modifying Values
deck <- read.csv("../data/cards.csv", stringsAsFactors = FALSE)
deck2 <- deck
## Changing Values in Place
vec <- rep(0, 6)
vec[1]
vec[1] <- 1000
vec
vec[c(1, 3, 5)] <- c(1, 1, 1)
vec
vec[c(1, 3, 5)] <- 2
vec
vec[4:6] <- vec[4:6] + 1
vec
vec[7] <- 0
vec
vec[9] <- 0
vec
vec[9] <- NULL
vec <- vec[-9]
vec
deck2$new <- 1:52
N <- nrow(deck2)
deck2$new2 <- 1:N
head(deck2)
deck2$new <- NULL
head(deck2)
deck2[seq(13, 52, by = 13), ]
deck2[seq(13, 52, by = 13), 1]
str(deck2[seq(13, 52, by = 13), 1])
deck2[seq(13, 52, by = 13), 1, drop = FALSE]
str(deck2[seq(13, 52, by = 13), 1, drop = FALSE])
deck2$value[seq(13, 52, by = 13)]
deck2[seq(13, 52, by = 13), "value"]
deck2[seq(13, 52, by = 13), 3]
deck2[seq(13, 52, by = 13), c(FALSE, FALSE, TRUE)]
deck2$value[seq(13, 52, by = 13)] <- 14
head(deck2, n = 13)
source("./shuffle.R", echo = TRUE)
deck3 <- shuffle(deck)
deck3
head(deck3)
## Logical Subsetting
vec <- vec[1:7]
vec
vec[c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)]
l <- c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)
w <- which(l)
vec[which(l)]
vec[w]
### Logical Tests
1 > 2
1 > c(0, 1, 2)
c(1, 2, 3) == c(3, 2, 1)
1 %in% c(3, 4, 5)
c(1, 2) %in% c(3, 4, 5)
c(1, 2, 3) %in% c(3, 4, 5)
c(1, 2, 3, 4) %in% c(3, 4, 5)
deck2$face == "ace"
which(deck2$face == "ace")
sum(deck2$face == "ace")
ace <- deck2$face == "ace"
deck2$value[ace]
deck2[ace, "value"]
deck2$value[deck2$face == "ace"]
ace3 <- deck3$face == "ace"
deck3$value[ace3]
deck3[ace3, "value"]
deck3$value[ace3] <- 14
deck3$value[deck3$face == "ace"] <- 14
deck3
deck4 <- deck
deck4$value <- 0
deck4
deck4[, "value"] <- 10
head(deck4, 13)
deck4[, 3] <- 0
deck4$suit == "hearts"
h <-deck4$suit == "hearts"
which(h)
which(deck4$suit == "hearts")
deck4$value[deck4$suit == "hearts"]
deck4$value[h]
deck4$value[deck4$suit == "hearts"] <- 1
deck4$value
deck4$value[h] <- 10
deck4[h, "value"] <- 1
deck4$value
deck4$value[deck4$suit == "hearts"]
q <- deck4$face == "queen"
q
deck4[q, ]
deck4[deck4$face == "queen", ]
(s <- deck4$suit == "spades")
deck4[s, ]
deck4[deck4$suit == "spades", ]
## Boolean Operators
a <- c(1, 2, 3)
b <- c(1, 2, 3)
c <- c(1, 2, 4)
a == b
b == c
a == b & b == c
deck4$face == "queen" & deck4$suit == "spades"
q & s
which(deck4$face == "queen" & deck4$suit == "spades")
which(q & s)
queenOfSpades <- deck4$face == "queen" & deck4$suit == "spades"
queenOfSpades
queen_spades <- q & s
queen_spades
which(queenOfSpades)
deck4[queenOfSpades, ]
deck4$value[queenOfSpades]
deck4[queen_spades, ]
deck4[queen_spades, "value"]
deck5 <- deck
deck5
facecard <- deck5$face %in% c("king", "queen", "jack")
facecard
which(facecard)
deck5[facecard, ]
deck5[facecard, "value"]
deck5$value[facecard] <- 10
head(deck5, 13)
## Missing Information
1 + NA
NA == 1
c(1, 2, NA) == c(1, 2, 3)
### na.rm
c(NA, 1:50)
mean(c(NA, 1:50))
mean(c(NA, 1:50), na.rm = TRUE)
### is.na
NA == NA
c(1, 2, 3, NA) == NA
vec <- c(1, 2, 3, NA)
is.na(vec)
which(is.na(vec))
ace <- deck$face == "ace"
deck$value[ace] <- NA
deck
deck[ace, "value"] <- 14
deck3 <- deck
deck3 <- shuffle(deck)
deck3
ace3 <- deck3$face == "ace"
ace3
deck3[ace3, "face"]
deck3$value[deck3$face == "ace"]
deck3$value[ace3] <- NA
deck3
ls()
save.image(file = "./r_modifying_values.RData")