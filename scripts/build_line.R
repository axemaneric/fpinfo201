library(dplyr)
library(plotly)
library(lubridate)
source("analysis.R")

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

  # filter based on category checkboxes
  final_data <- my_data[0,]
  my_line <- plot_ly(final_data, x = ~trending_date, type = "scatter", mode = "line")
  for (i in 1 : length(yvar)){
    draw_line(final_data, yvar[[i]], my_line)
  }

}

# a function that draws an extra line onto the plot
draw_line <- function(data, class, line){
  data <- final_data
  class <- "Sports"
  data <- filter(data, category == class) %>% 
    group_by(trending_date) %>% 
    summarize(view_sum = sum(as.numeric(views)))
  line <- line %>% 
    add_trace(y = ~view_sum, type = "scatter", mode = "line")
}