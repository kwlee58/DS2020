party <- c("더불어민주당", "자유한국당", "국민의당", "바른정당", "정의당", "기타정당", "없음/모름/무응답")
counts <- c(396, 109, 97, 51, 51, 29, 267)
prop.in <- c(20.0, 0.0, 2.7, 5.7, 29.5, 11.4, 2.3)
counts.in <- round(counts * prop.in / 100)
counts.not <- counts - counts.in
counts.df <- data.frame(지지정당 = party, 사례수 = counts, 참여 = counts.in, 미참여 = counts.not)
counts.df
par(family = "HCR Dotum LVT")
barplot(t(as.matrix(counts.df[, 3:4])), axes = FALSE, beside = FALSE, names.arg = counts.df[, 1], legend.text = c("참여", "미참여"), col = c("cyan", "red"))
axis(side = 2, at = counts, labels = counts)
main.title <- "지지정당 별 민주당 경선 참여 비교"
sub.title <- "JTBC 뉴스룸, 한국리서치 2017. 3. 14"
main.text <- "더불어민주당 지지자 중 20%,\n 정의당 지지자 중 29.5%,\n 더불어민주당 경선 참여"
title(main = main.title, sub = sub.title, cex.main = 2)
text(4, 250, main.text)
library(reshape2)
counts.df$party.f <- factor(party, levels = party)
counts.df
str(counts.df)
counts.df.melt <- melt(counts.df, id.vars = "party.f", measure.vars = c("사례수", "미참여", "참여"), variable.name = "Participation", value.name = "Counts")
counts.df.melt2 <- counts.df.melt[counts.df.melt$Participation != "사례수", ]
library(ggplot2)
# ggplot(data = counts.df.melt2, mapping = aes(x = party.f, y = Counts, fill = Participation)) +
#   geom_bar(stat = "identity") + 
#   theme_bw(base_family = "HCR Dotum LVT") +
#     scale_fill_manual(name = "경선참여", values = c("red", "cyan")) +
#     scale_x_discrete(name = "지지정당") +
#     scale_y_continuous(name = "사례수", breaks = counts, labels = counts) +
#     labs(title = main.title, subtitle = sub.title) +
g1 <- ggplot(data = counts.df.melt2, mapping = aes(x = party.f, y = Counts, fill = Participation)) 
g2 <- g1 + 
  geom_bar(stat = "identity") 
g2
g3 <- g2 +
  theme_bw(base_family = "HCR Dotum LVT")
g3
g4 <- g3 + 
    scale_fill_manual(name = "경선참여", values = c("red", "cyan"))
g4
g5 <- g4 + 
    scale_x_discrete(name = "지지정당")
g5
g6 <- g5 +
    scale_y_continuous(name = "사례수", breaks = counts, labels = counts)
g6
g7 <- g6 +
    labs(title = main.title, subtitle = sub.title)
g7
g8 <- g7 +
  theme(plot.title = element_text(hjust = 0.5))
g8
