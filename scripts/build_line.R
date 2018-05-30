library(dplyr)
library(plotly)
library(lubridate)

build_line <- function(my_data, xvar, yvar){
  #testing
  my_data <- new_data
  xvar <- list("2017-11-30", "2018-01-01")
  yvar <- list("Entertainment", "People & Blogs", "Sports")
  
  # filter based on date slider
  date_one <- as.Date(xvar[[1]])
  date_two <- as.Date(xvar[[2]])
  my_data <- my_data %>% 
    filter(trending_date > date_one & trending_date < date_two)
  
  # filter out the data related to the last category in the list
  data <- filter(my_data, category == yvar[[length(yvar)]]) %>%
    group_by(trending_date) %>%
    summarize(video = length(video_id))
  line_one <- yvar[[length(yvar)]]
  
  # draw out the first line based on the data
  my_line <- plot_ly(data, x = ~trending_date, y = ~video,
                     type = "scatter", name = line_one, mode = "line") 
  
  # draw out the rest of the lines based on other categories
  for (i in 1 : (length(yvar)-1)){
    col_name <- paste0("video", i)
    line_name <- yvar[[i]]
    new_data <- filter(my_data, category == yvar[[i]]) %>%
      group_by(trending_date) %>%
      summarize(video = length(video_id))
    data <- data %>% 
      mutate(!!col_name := new_data$video)
    yaxis = data[[col_name]]
    my_line <- my_line %>% 
      add_trace(y = yaxis, name = line_name, type = "scatter", mode = "line")
  }
  
  # formatting the line plot
  my_line <- my_line %>% 
    layout(title = "Number of Trending Videos in Catogories Change in Time",
           xaxis = list(title = "Date"),
           yaxis = list (title = "Number of Videos"))
  my_line
  
}

