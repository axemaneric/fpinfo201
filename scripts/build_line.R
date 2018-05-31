library(dplyr)
library(plotly)
library(lubridate)

build_line <- function(my_data, xvar, yvar) {
  # filter based on date slider
  new_data <- read.csv('data/new_data.csv')
  new_data %>% mutate_if(is.factor, as.character) -> new_data
  my_data <- new_data
  
  date_one <- as.Date(xvar[[1]])
  date_two <- as.Date(xvar[[2]])
  my_data <- my_data %>%
    filter(trending_date > date_one & trending_date < date_two)
  
  # filter out the data related to the last category in the list
  category_count <- filter(my_data, category == yvar[[length(yvar)]]) %>%
    group_by(trending_date) %>%
    summarize(frequency = n())
  line_one <- yvar[[length(yvar)]]
  
  # draw out the first line based on the data
  my_line <- plot_ly(category_count,
                     x = ~trending_date, y = category_count$frequency,
                     type = "scatter", name = line_one, mode = "line"
  )
  
  # draw out the rest of the lines based on other categories
  for (i in 1:(length(yvar) - 1)) {
    category_count2 <- filter(my_data, category == yvar[[i]]) %>%
      group_by(trending_date) %>%
      summarize(frequency = n())
    line_name <- yvar[[i]]
    my_line <- my_line %>%
      add_trace(category_count2,
                y = category_count2$frequency, 
                name = line_name,
                type = "scatter", 
                mode = "line")
  }
  
  
  # formatting the line plot
  my_line <- my_line %>%
    layout(
      title = "Number of Trending Videos in Categories Change in Time",
      xaxis = list(title = "Date"),
      yaxis = list(title = "Number of Videos")
    )
  
  my_line
}
