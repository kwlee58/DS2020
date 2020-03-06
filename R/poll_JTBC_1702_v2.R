candidates <- c("문재인", "안희정", "황교안", "안철수", "이재명", "유승민") 
rates <- c(33, 22, 9, 9, 5, 2)
party <- c("더불어민주당", "자유한국당", "국민의당", "바른정당")
colour.party <- c("skyblue", "lightgrey", "darkgreen", "darkblue")
candidates.party <-  c("더불어민주당", "더불어민주당", "자유한국당", "국민의당", "더불어민주당", "바른정당")
match(candidates.party, party)
(candidates.colour <- colour.party[match(candidates.party, party)])
barplot(rates)
b1 <- barplot(rates, 
              axes = FALSE, 
              col = candidates.colour, 
              names.arg = candidates,
              cex.names = 1.2)
text(x = b1, y = rates + c(rep(-3, 4), rep(1.5, 2)), labels = rates, cex = 1.2)
main.title <- "대선주자 지지율(%)"
title(main = main.title, cex.main = 1.5)
library(ggplot2)
candidates.f <- factor(candidates, levels = candidates)
rates.df <- data.frame(후보 = candidates.f, 
                       정당 = candidates.party, 
                       색깔 = candidates.colour,
                       지지도 = rates)
g0 <- ggplot(data = rates.df, 
             mapping = aes(x = 후보, y = 지지도))
(g1 <- g0 +
  geom_bar(stat = "identity"))
(g1 <- g0 +
  geom_bar(stat = "identity", 
           fill = candidates.colour))
(g2 <- g1 +
  theme_bw())
(g3 <- g2 +
  geom_text(mapping = aes(x = 후보, 
                          y = 지지도 + c(rep(-3, 4), rep(2, 2)), 
                          label = 지지도), 
                          size = 6))
(g4 <- g3 +
  labs(title = main.title))
(g5 <- g4 +
  theme(plot.title = element_text(hjust = 0.5)))
(g6 <- g5 +
  scale_y_continuous(breaks = rates, labels = rates))
(g7 <- g6 +
  theme(panel.border = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_text(vjust = 0),
        axis.ticks = element_blank(), 
        axis.text.y = element_blank()))
(g8 <- g7 +
    ggtitle("") +
    annotate("text", 
             x = mean(b1), 
             y = Inf, 
             label = main.title, 
             vjust = 1.5, 
             size = 6))
