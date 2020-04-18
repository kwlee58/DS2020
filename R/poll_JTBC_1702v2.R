rates <- c(33, 22, 9, 9, 5, 2)
barplot(rates)
names(rates) <- c("문재인", "안희정", "황교안", "안철수", "이재명", "유승민")
col.names <-  c("skyblue", "skyblue", "lightgrey", "darkgreen", "skyblue", "lightblue")
b1 <- barplot(rates, axes = FALSE, 
              col = col.names, cex.names = 1.5)
text(x = b1, y = rates + c(rep(-3, 4), rep(1.5, 2)), labels = rates, cex = 2)
main.title <- "차기 대선주자 지지율(%)"
title(main = main.title, cex.main = 2)
library(ggplot2)
rates.df <- data.frame(후보 = factor(names(rates), levels = names(rates)), 
                       지지도 = rates)
g1 <- ggplot(data = rates.df, mapping = aes(x = 후보, y = 지지도))
(g2 <- g1 +
  geom_bar(stat = "identity"))
(g3 <- g2 +
  geom_bar(stat = "identity", 
           fill = col.names))
(g4 <- g3 +
  theme_bw() +
  geom_text(mapping = aes(x = 후보, 
                          y = 지지도 + c(rep(-3, 4), rep(2, 2)), 
                          label = 지지도), 
                          size = 6) +
  labs(title = main.title) +
  theme(plot.title = element_text(hjust = 0.5)))
(g5 <- g4 +
  scale_y_continuous(breaks = rates, labels = rates))
