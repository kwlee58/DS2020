horsekick %T>%
  plot(Cum ~ Deaths, data = .,
       xlim = c(-0.5, 4.5), ylim = c(50, 100), 
       xlab = "사망자 수", ylab = "누적 백분률(%)", 
       yaxt = "n")
#> `axis()` 함수를 이용하여 `y`축 설정. `las = 2`의 역할에 유의
horsekick %$%
  axis(side = 2,
       at = Cum, 
       labels = format(Cum, digits = 1, nsmall = 1),
       las = 2)
abline(v = 0:4, lty = 3)
lines(x = c(0, 1), y = rep(horsekick$Cum[1], 2), lty = 1, lwd = 2)
lines(x = c(1, 2), y = rep(horsekick$Cum[2], 2), lty = 1, lwd = 2)
lines(x = c(2, 3), y = rep(horsekick$Cum[3], 2), lty = 1, lwd = 2)
lines(x = c(3, 4), y = rep(horsekick$Cum[4], 2), lty = 1, lwd = 2)
lines(x = c(4, 5), y = rep(horsekick$Cum[5], 2), lty = 1, lwd = 2)
horsekick %$%
  points(x = Deaths, y = Cum,
         pch = 21, bg = "black", col = "black")
horsekick %$%
  points(x = Deaths[2:5], y = Cum[1:4],
         pch = 21, bg = "white", col = "black")
