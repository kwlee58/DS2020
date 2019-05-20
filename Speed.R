# Speed
## Vectorized code
abs_loop <- function(vec) {
  for (i in 1:length(vec)) {
    if (vec[i] < 0) {
      vec[i] <- -vec[i]
    }
  }
  vec
}
abs_set <- function(vec) {
  negs <- vec < 0
  vec[negs] <- vec[negs] * -1
  vec
}
long <- rep(c(-1, 1), 5000000)
system.time(abs_loop(long))
system.time(abs_set(long))
system.time(abs(long))
## How to Write Vectorized Code
vec <- 1:10 * rep(c(1, -1), 5)
vec
vec < 0
vec[vec < 0]
vec[vec < 0] * -1
vec[vec < 0] <- vec[vec < 0] * -1
vec
vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")
many <- rep(vec, 1000000)
vec[vec == "DD"]
vec[vec == "C"]
vec[vec == "7"]
vec[vec == "B"]
vec[vec == "BB"]
vec[vec == "BBB"]
vec[vec == "0"]
vec[vec == "DD"] <- "joker"
vec[vec == "C"] <- "ace"
vec[vec == "7"] <- "king"
vec[vec == "B"] <- "queen"
vec[vec == "BB"] <- "jack"
vec[vec == "BBB"] <- "ten"
vec[vec == "0"] <- "nine"
vec
change_vec <- function(vec) {
  vec[vec == "DD"] <- "joker"
  vec[vec == "C"] <- "ace"
  vec[vec == "7"] <- "king"
  vec[vec == "B"] <- "queen"
  vec[vec == "BB"] <- "jack"
  vec[vec == "BBB"] <- "ten"
  vec[vec == "0"] <- "nine"
  
  vec
}

system.time(change_vec(many))
change_vec2 <- function(vec) {
  tb <- c("DD" = "joker", "C" = "ace", "7" = "king", "B" = "queen", "BB" = "jack", 
          "BBB" = "ten", "0" = "nine")
  unname(tb[vec])
}
change_vec2(vec)
system.time(change_vec2(many))
## How to Write Fast for Loops in R
system.time(
  {
  output <- rep(NA, 1000000)
  for (i in 1:1000000) 
    {
    output[i] <- i + 1
    }
  }
)
system.time(
  {
    output <- NA
    for (i in 1:1000000)
    {
      output[i] < i + 1
    }
  }
)
## Vectorized Code in Practice
load("./Loops.RData")
play
score
### Law of Large Numbers
system.time(
  {
    winnings <- vector(length = 1000000)
    for (i in 1:1000000) {
      winnings[i] <- play()
    }
  }
)
mean(winnings)
sum(combos$prize * combos$prob)
### 0.934356
system.time({
for (i in 1:1000000) {
  winnings[i] <- play()
  }
})
get_many_symbols <- function(n) {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  vec <- sample(wheel, size = 3 * n, replace = TRUE,
                prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
  matrix(vec, ncol = 3)
}

get_many_symbols(5)
symbols <- get_many_symbols(20)
symbols
cherries <- rowSums(symbols == "C")
diamonds <- rowSums(symbols == "DD")
cherries + diamonds
# Symbols should be a matrix with a column for each slot machine window
score_many <- function(symbols) {
  # Step 1: Assign base prize based on cherries and diamonds -----
  ## Count the number of cherries and diamonds in each combination
  cherries <- rowSums(symbols == "C")
  diamonds <- rowSums(symbols == "DD")
  
  ## Wild diamonds count as cherries
  prize <- c(0, 2, 5)[cherries + diamonds + 1]
  
  ## ...but not if there are zero real cherries
  ### (Cherries is coerced to FALSE where cherries == 0)
  prize[!cherries] <- 0
  
  # Step 2: Change prize for combinations that contains three of a kind
  same <- symbols[, 1] == symbols[, 2] & symbols[, 2] == symbols[, 3]
  payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize[same] <- payoffs[symbols[same, 1]]
  
  # Step 3: Change prize for combinations that contain all bars -----
  bars <- symbols == "B" | symbols == "BB" | symbols == "BBB"
  all_bars <- bars[, 1] & bars[, 2] & bars[, 3] & !same
  prize[all_bars] <- 5
  
  # Step 4: Handle wilds
  
  ## combos with two diamonds
  two_wilds <- diamonds == 2
  
  ### Identify the nonwild symbol
  one <- two_wilds & symbols[, 1] != symbols[, 2] & symbols[, 2] == symbols[, 3]
  two <- two_wilds & symbols[, 1] != symbols[, 2] & symbols[, 1] == symbols[, 3]
  three <- two_wilds & symbols[, 1] == symbols[, 2] & symbols[, 2] != symbols[, 3]
  
  ### Treat as a three of a kind
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  ## combos with one wild
  one_wild <- diamonds == 1
  
  ### Treat as all bars (if appropriate)
  wild_bars <- one_wild & (rowSums(bars) == 2)
  prize[wild_bars] <- 5
  
  ### Treat as three of a kind (if appropriate)
  one <- one_wild & symbols[, 1] == symbols[, 2]
  two <- one_wild & symbols[, 2] == symbols[, 3]
  three <- one_wild & symbols[, 3] == symbols[, 1]
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  # Step 5: Double prize for every diamond in combo ----
  unname(prize * 2 ^ diamonds)
  
}

play_many <- function(n) {
  symb_mat <- get_many_symbols(n = n)
  data.frame(w1 = symb_mat[, 1], w2 = symb_mat[, 2], w3 = symb_mat[, 3], 
             prize = score_many(symb_mat))
}
play_many(10)
system.time(play_many(1000000))
