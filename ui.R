# ui.R
library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)
library(lubridate)

categories <- list(
  "Autos & Vehicles", "Comedy", "Education","Entertainment", 
  "Film & Animation", "Gaming", "Howto & Style", "Music",
  "News & Politics", "Nonprofits & Activism", "People & Blogs",
  "Pets & Animals", "Science & Technology","Shows", "Sports",
  "Travel & Events"
)

shinyUI(navbarPage(
  "YouTube Trending Analysis",

  # Tab for line graph of trending categories
  tabPanel(
    "Video Count",
    titlePanel("Video Count Per Trending Category"),
    sidebarLayout(
      # Sidebar for widgets
      sidebarPanel(
        checkboxGroupInput(
          "cat.line",
          label = "Pick Categories:",
          choices = categories,
          selected = list("Entertainment", "People & Blogs", "Sports")
        ),
        sliderInput(
          "date.range",
          label = "Choose Date Range:",
          min = as.Date("2017-11-14"),
          max = as.Date("2018-05-09"),
          value = c(as.Date("2017-11-30"), as.Date("2018-01-01"))
        )
      ),

      # Main panel for displaying the line graph
      mainPanel(
        plotlyOutput("line")
      )
    )
  ),

  # Tab for bar graph top 25 videos of the trending page filtered
  # by likes, dislikes, rating, views, depending on category
  tabPanel(
    "Top 25",
    titlePanel("Top 25 Videos According to Statistic"),
    sidebarLayout(
      # Sidebar for widgets
      sidebarPanel(
        checkboxGroupInput(
          "cat.bar",
          label = "Pick Categories:",
          choices = categories,
          selected = categories
        ),
        selectInput(
          "yvar",
          label = "Choose a Statistic:",
          choices = list(
            "likes",
            "dislikes",
            "views",
            "Rating"
          )
        )
      ),

      # Main panel for the bar graph
      mainPanel(
        plotlyOutput("bar")
      )
    )
  ),

  # Tab for word cloud of most frequent used tags withing trending videos
  # according to a single category
  tabPanel(
    "Word Cloud",
    titlePanel("Word Cloud of Most Frequent Tags Per Category"),
    sidebarLayout(
      # Sidebar for widget
      sidebarPanel(
        selectInput(
          "category",
          label = "Choose a Category",
          choices = categories
        )
      ),

      # Main panel for word cloud
      mainPanel(
        plotOutput("cloud")
      )
    )
  )
))
