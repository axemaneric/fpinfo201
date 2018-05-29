library(plotly)
library(stringr)
library(dplyr)
library(rlang)
source("analysis.R")

build_bar <- function(data, yvar = "", cat = "") {
  
  data <- data %>% 
    arrange(desc(data[, yvar])) %>% 
    filter(category == cat) %>% 
    distinct(title, .keep_all = TRUE) %>% 
    head(25)

  data$title <- factor(data$title, levels = data$title)
  options <- list("likes" = "MOST LIKED", 
                  "dislikes" = "MOST DISLIKED", 
                  "views" = "MOST VIEWED",
                  "Rating" = "HIGHEST RATING")
  
  link <- paste0("<a href = 'https://www.youtube.com/", data$video_id, "></a>")
  
  p <- plot_ly(data, 
               x = ~title, 
               y = data[, yvar], type = 'bar',
               colors = "Set2",
               color = ~category) %>% 
    layout(yaxis = list(title = toupper(yvar)),
           xaxis = list(title = "VIDEO"),
           title = toupper(paste("Top 25", options[yvar], "Videos")))
  p
}

build_bar(new_data, "dislikes", c())
))