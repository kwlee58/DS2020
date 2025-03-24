library(readxl)
library(magrittr)
getwd()
data <- 
  read_excel("./data/Team_Project_P2P.xlsx", 
             range = "B1:H158",
             col_names = TRUE)
data <- data[, c(1, 2, 6)]
names(data) <- c("name", "id", "scores")
mean_scores <- 
  tapply(data$scores, data$id, mean) %>%
  round(digits = 2)
str(mean_scores)
mean_score <- 
  data.frame(id = names(mean_scores), scores = mean_scores, row.names = NULL)
write.csv(mean_score, file = "./data/Team_Project_P2p_scores.csv", fileEncoding = "UTF-8")  
