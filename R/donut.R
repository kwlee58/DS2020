#set the working directory
setwd("/Users/DrVenkman/The Gatekeepers Folder/")

require(tidyverse) #data manipulation

exp.ser %
filter(variable == "Export of Services")

exp.ser % group_by(year) %>% mutate(pos = cumsum(value)- value/2)

p <- ggplot(exp.ser, aes(x = 2, y = value, fill = type))+
  geom_bar(stat="identity")+
  geom_text(aes(label = value, y = pos), size=10, fontface="bold")+
  xlim(0.5, 2.5) +
  coord_polar(theta = "y")+
  labs(x=NULL, y=NULL)+
  labs(fill="") +
  scale_fill_manual(values = c(Remaining = "blue", Transportation = "#E69F00", Travel= "#D55E00"), name="")+
  ggtitle("Exports of services by EBOPS category, 2013")+
  theme_bw()+
  theme(plot.title = element_text(face="bold",family=c("sans"),size=15),
        legend.text=element_text(size=10),
        axis.ticks=element_blank(),
        axis.text=element_blank(),
        axis.title=element_blank(),
        panel.grid=element_blank(),
        panel.border=element_blank())
