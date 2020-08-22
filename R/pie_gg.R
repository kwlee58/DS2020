pie_gg <-
function(df){
  n <- length(names(df))
  y_coord <- cumsum(df[, 2]) - df[, 2] / 2
  pie_label <- paste(levels(df[, 1]), 
                     format(df[, 2], big.mark = ","), 
                     sep = "\n") 
  ggplot(df, aes(x = "", 
                 y = df[, 2], 
                 fill = df[, 1])) + 
    geom_bar(width = 1, 
             stat = "identity", 
             position = position_stack(reverse = TRUE)) +
    geom_text(aes(y = y_coord), 
              label = pie_label, 
              size = 5,
              position = position_identity()) +
    guides(fill = "none") +
    theme_void() +
    coord_polar(theta = "y", 
                start = 3 * pi / 2, 
                direction = -1)
  }
