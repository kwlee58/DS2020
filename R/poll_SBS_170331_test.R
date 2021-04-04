## Font Family Extension
# library(extrafont)
## Data 
candidates <- c("문재인", "안철수", "안희정", "이재명", "홍준표", "김진태", "심상정", "유승민") 
rates <- c(35.2, 17.4, 12.0, 9.5, 7.7, 5.3, 3.4, 2.6)
party <- c("더불어민주당", "자유한국당", "국민의당", "정의당", "바른정당")
colour.party <- c("blue", "lightgrey", "darkgreen", "purple", "darkblue")
candidates.party <-  c("더불어민주당", "국민의당", "더불어민주당",  "더불어민주당", "자유한국당", "자유한국당", "정의당", "바른정당")
match(candidates.party, party)
candidates.colour <- colour.party[match(candidates.party, party)]
## strsplit
c.rates <- format(rates, nsmall = 1, justify = "right")
a <- sapply(strsplit(c.rates, "[.]"), `[`, 1)
b <- sapply(strsplit(c.rates, "[.]"), `[`, 2)
b.perc <- paste(".", b, "%", sep = "")
## Colours for rates
col.rates <- c("red", "orange", rep("darkblue", 6))
## Barplot
barplot(rates)
## Font Specification
# par(family = "Malgun Gothic")
## Names under Bars
b1 <- barplot(rates, 
              axes = FALSE, 
              col = "dodgerblue", 
              names.arg = candidates,
              cex.names = 1.2,
              ylim = c(0, 38))
## Names closer to Bars using mtext
b1 <- barplot(rates, 
              axes = FALSE, 
              col = "dodgerblue", 
              names.arg = NULL,
              cex.names = 1.2,
              ylim = c(0, 38))
mtext(side = 1, at = b1, line = 0, text = candidates)
## Rates written on top of the Bars with different Colours
text(x = b1, y = rates + rep(1.5, 8), 
    labels = paste(rates, "%", sep = ""), 
    col = col.rates, 
    cex = 1.2)
main.title <- "대선주자 지지도"
note.text <- "조사기관:리얼미터, 총응답자:전국 성인 1,525명, 응답률:9.5%, 표준오차:95%신뢰수준 2.5%,
조사방법:유선 ARS 10%, 무선 ARS 71%, 무선전화면접 19%, 조사기간:2017년 3월27일(월)~29일(수)" 
## Main title inside the plot region
title(main = main.title, cex.main = 1.5, line = -2)
## Rates with different font size for digits
b1 <- barplot(rates, 
              axes = FALSE, 
              col = "dodgerblue", 
              names.arg = NULL,
              cex.names = 1.2,
              ylim = c(0, 38))
mtext(side = 1, at = b1, line = 0, text = candidates)
## text for integer part
text(x = b1 - c(rep(0.4, 3), rep(0.3, 5)), y = rates + rep(1.5, 8), 
     labels = a, 
     col = col.rates, 
     cex = 1.6)
## text for digits
text(x = b1 + 0.2, y = rates + rep(1.5, 8), 
     labels = b.perc, 
     col = col.rates, 
     cex = 1.2)
## Rectagle for main title
rect(xleft = mean(b1) - 2, ybottom = max(rates) - 6, xright = mean(b1) + 2, 
     ytop = max(rates), col = "dodgerblue4")
## Main title
text(x = mean(b1), y = max(rates) - 3, labels = main.title, col = "white", cex = 1.5)
## Text for notes
text(x = mean(b1) - 2, y = max(rates) - 8, labels = note.text, cex = 0.5, adj = 0)
## ggplots
library(ggplot2)
## Data for ggplot
candidates.f <- factor(candidates, levels = candidates)
rates.df <- data.frame(후보 = candidates.f, 
                       정당 = candidates.party, 
                       색깔 = candidates.colour,
                       지지도 = rates)
## data and mapping
g0 <- ggplot(data = rates.df, 
             mapping = aes(x = 후보, y = 지지도))
## geom_bar with single colour for the bars
(g1 <- g0 +
  geom_bar(stat = "identity", fill = "dodgerblue"))
## Fill the bars with party colours
(g1.1 <- g0 +
  geom_bar(stat = "identity", 
           fill = candidates.colour))
## Font family setting
(g2 <- g1 +
  theme_bw(base_family = ""))
## Add rates on top of the bars
(g3.0 <- g2 +
  geom_text(mapping = aes(x = 후보, 
                          y = 지지도 + rep(1, 8), 
                          label = paste(지지도, "%", sep = "")), 
                          size = 6))
## Different font size for digits
(g3 <- g2 +
    geom_text(mapping = aes(x = 후보, 
                            y = 지지도 + rep(1, 8), 
                            label = a), 
              hjust = 1,
              size = 8,
              colour = col.rates) +
    geom_text(mapping = aes(x = 후보, 
                          y = 지지도 + rep(1, 8), 
                          label = b.perc),
              hjust = 0,
              size = 5,
              colour = col.rates))
## Main title (left-justified)
(g4 <- g3 +
  labs(title = main.title))
## Main title at the center
(g5 <- g4 +
  theme(plot.title = element_text(hjust = 0.5)))
## Rates at y-axis
(g6 <- g5 +
  scale_y_continuous(breaks = rates, labels = rates))
## Clear axes
(g7 <- g6 +
  theme(panel.border = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks = element_blank(), 
        axis.text.y = element_blank()))
## Names closer to the bars
(g8 <- g7 +
    geom_text(mapping = aes(x = 후보,
                            y = -1,
                            label = 후보),
              size = 5,
              family = ""))
## Main title as usual
(g9 <- g8 +
    ggtitle("") +
    annotate("text", 
             x = mean(b1), 
             y = max(rates) - 3, 
             label = main.title, 
             vjust = 0, 
             size = 10, 
             family = ""))
## geom_label to enclose the main title in bounding box
(g9.1 <- g8 +
    ggtitle("") +
    geom_label(mapping = aes(x = mean(b1), 
                             y = max(rates) - 3, 
                             label = main.title),
               label.padding = unit(0.9, "lines"),
               size = 10,
               fill = "dodgerblue4",
               colour = "white",
               family = ""))
## Notes
(g9.2 <- g9.1 + 
    annotate("text", x = mean(b1) - 1, y = max(rates) - 8, 
             label = note.text, 
             size = 2, 
             hjust = 0))
  