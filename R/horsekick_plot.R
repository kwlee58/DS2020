plot(x = n_deaths, y = horsekick_cum, 
     xlim = c(-0.5,4.5), ylim = c(50, 100), 
     xlab = "사망자 수", ylab = "누적 백분률(%)", 
     yaxt = "n")
axis(side = 2,
     at = c(50, horsekick_cum), 
     labels = c("", format(horsekick_cum[1:4], nsmall = 1), ""),
     las = 2)
axis(side = 2,
     at = c(48.5, horsekick_cum[5] + 1.5), 
     tick = FALSE,
     labels = format(c(50, horsekick_cum[5]), nsmall = 1),
     las = 2)
abline(v = 0:4, lty = 3)
lines(c(0, 1), rep(horsekick_cum[1], 2), lty = 1, lwd = 2)
lines(c(1, 2), rep(horsekick_cum[2], 2), lty = 1, lwd = 2)
lines(c(2, 3), rep(horsekick_cum[3], 2), lty = 1, lwd = 2)
lines(c(3, 4), rep(horsekick_cum[4], 2), lty = 1, lwd = 2)
lines(c(4, 5), rep(horsekick_cum[5], 2), lty = 1, lwd = 2)
points(x = n_deaths, y = horsekick_cum,
       pch = 21, bg = "black", col = "black")
points(x = tail(n_deaths, -1), y = head(horsekick_cum, -1),
       pch = 21, bg = "white", col = "black")
