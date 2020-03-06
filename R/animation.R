library(animation)
ani.options(interval = 1)
plot.new()
for(i in 10:0){
  rect(xleft = 0, ybottom = 0, xright = 1, ytop = 1, col = "yellow")
  size = 21 - i
  text(x = 0.5, y = 0.5, 
       labels = i, cex = size, col = rgb(red = 0, green = 0, blue = 1, alpha = 0.5))
  ani.pause()
}

ani.options(interval = 1)
# while(TRUE)
i <- 1
while(i <= 10){
  y <- runif(n = 5, min = 0, max = 1)
  barplot(y, ylim = c(0, 1), col = rainbow(5), main = paste("i = ", i), cex.main = 2)
  ani.pause()
  i <- i + 1
}