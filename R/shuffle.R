deal <-
function(cards) { 
  cards[1, ]
  }
shuffle <-
function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}
