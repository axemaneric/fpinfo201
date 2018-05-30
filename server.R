# server.R
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)
library(jsonlite)
library(httr)

# Read in filtered data
new_data <- read.csv('data/new_data.csv')
new_data %>% mutate_if(is.factor, as.character) -> new_data

# Split the tags into a list
new_data$tags <- as.list(strsplit(new_data$tags, "|", fixed = T))

# Change the format of date
new_data$trending_date <- paste0("20",new_data$trending_date)
new_data$trending_date <- as.Date(new_data$trending_date, "%Y.%d.%m")

# Source the graphs and plots to be used as outputs for the application
source("scripts/build_line.R")
source("scripts/channel_compare.R")
source("scripts/cloud.R")

# Start shiny server
shinyServer(function(input, output) {
  
  output$line <- renderPlotly(
    return(build_line(new_data, input$date.range, input$cat.line))
  )
  
  output$bar <- renderPlotly(
    return(build_bar(new_data, input$yvar, input$cat.bar))
  )
  
  output$cloud <- renderPlot(
    return(build_cloud(new_data, input$category))
  )
})