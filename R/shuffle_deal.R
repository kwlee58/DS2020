load("./R/r_notation.RData")
shuffle_deal <- function(cards){
  deck <- shuffle(cards)
  deal(deck)$suit
}
suits <- replicate(10000, shuffle_deal(deck2))
table(suits)
library(ggplot2)
qplot(suits)