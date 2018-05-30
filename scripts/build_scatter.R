# Build Scatter file: function that returns a plotly Scatter plot
library(plotly)
library(stringr)
#source("analysis.R")

#data2 <- read.csv("../data/scatterstats.csv", stringsAsFactors = FALSE)
#data2 <- data2 %>% 
#  filter(Avg.Likes < 500000)

### Build Scatter ###
# xvar = input
build_scatter <- function(data, search = "", search2 = "", xvar, unique = FALSE) {
  # Get x and y max
  
  data <- data %>% 
    filter(grepl(search, "channel_title") | grepl(search2, "channel_title"))
  
  xmax <- max(data[, xvar]) * 1.2
  ymax <- max(data[,"Frequency"]) * 1.2
  colorscale <- data[, "Main.Category"]
  
  # Plot data
  plot_ly(type = "scatter",
          x = data[, xvar],
          y = data[, "Frequency"], 
          mode = "markers", 
          color = colorscale,
          colors = "Set1",
          marker = list(
            opacity = 1,
            size = 7.5
          )) %>% 
    layout(xaxis = list(range = c(0, xmax), title = toupper(xvar)), 
           yaxis = list(range = c(0, ymax), title = "Frequency")
    ) %>% 
    return()
}

#build_scatter(data2, "", "", "Avg.Likes", FALSE)
