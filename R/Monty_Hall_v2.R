monty_hall <- function() {
  key <- sample(1:3, size = 1)
  goat <- setdiff(1:3, key)
  contestant <- sample(1:3, size = 1)
  monty <- ifelse(contestant == key, sample(goat, size = 1), setdiff(goat, contestant))
  switch <- setdiff(1:3, c(contestant, monty))
  result <- ifelse(switch == key, "Switching wins", "Staying wins")
  # result
  c("Key" = key, "Contestant" = contestant, "Monty" = monty, "Switch" = switch, "Result" = result)
}
monty_hall()
N <- 100
monty_result <- replicate(N, monty_hall())
monty_result[5, ]
table(unlist(monty_result[5, ]))
sum(monty_result[5, ] == "Switching wins")/N
cumsum(monty_result[5, ] == "Switching wins")
cumsum(monty_result[5, ] == "Staying wins")
y_switch <- cumsum(monty_result[5, ] == "Switching wins")
y_stay <- cumsum(monty_result[5, ] == "Staying wins")
monty_plot <- function(N) {
  monty_result <- replicate(N, monty_hall())
  y_switch <- cumsum(monty_result[5, ] == "Switching wins")
  y_stay <- cumsum(monty_result[5, ] == "Staying wins")
plot(x = 1:N, 
     y = y_switch / N, 
     pch = 23, 
     col = "red", 
     bg = "red", 
     ylim = c(0, 4/5),
     xlab = "Number of Trials",
     ylab = "Proportion of Wins",
     yaxt = "n",
     cex = 0.7)
axis(side = 2, 
     at = c(0, 1/3, 2/3, 3/4), 
     labels = c("0", "1/3", "2/3", "3/4"), las = 2)
points(x = 1:N, 
       y = y_stay / N, 
       pch = 22, 
       col = "blue", 
       bg = "blue", 
       cex = 0.7)
abline(h = c(1/3, 2/3), lty = 3)
title(main = "Monty Hall Simulation")
legend("topleft", 
       inset = 0.05, 
       legend = c("Switching wins", "Staying wins"), 
       pch = c(23, 22), 
       col = c("red", "blue"), 
       pt.bg = c("red", "blue"))
sum(monty_result[5, ] == "Switching wins")/N
}
# monty_plot(30)
Prop_Switching_wins <- monty_plot(30)
Prop_Switching_wins
Prop_Switching_wins_100 <- replicate(100, monty_plot(30))
summary(Prop_Switching_wins_100)
