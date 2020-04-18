# R Modifying Values
deck <- read.csv("./data/cards.csv", stringsAsFactors = FALSE)
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
vec <- vec[-8]
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
source("./R/shuffle.R", echo = TRUE)
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
h <- deck4$suit == "hearts"
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
save.image(file = "./R/r_modifying_values.RData")