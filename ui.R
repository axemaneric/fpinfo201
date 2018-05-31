# ui.R
library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)
library(lubridate)

categories <- list(
  "Autos & Vehicles", "Comedy", "Education", "Entertainment",
  "Film & Animation", "Gaming", "Howto & Style", "Music",
  "News & Politics", "Nonprofits & Activism", "People & Blogs",
  "Pets & Animals", "Science & Technology", "Shows", "Sports",
  "Travel & Events"
)

categories_line <- list(
  "Comedy", "Education", "Entertainment",
  "Film & Animation", "Howto & Style", "Music",
  "News & Politics", "People & Blogs",
  "Pets & Animals", "Science & Technology", "Sports"
)

shinyUI(navbarPage(
  "YouTube Trending Analysis",
  theme = shinytheme("yeti"),
  tabPanel(
    "Overview",
    
      tags$h1("Overview"),
      tags$p("This application allows for people to explore the different
             aspects of YouTube Trending Videos. This is mainly catered to
             those that classify as YouTubers and want to keep with the 
             latest trends that the website has to offer."),
    
    tags$hr(),
    
      tags$h1("What can you do?"),
      tags$br(),
      tags$h4("SEE THE HIGHEST STAT VIDEOS"),
      tags$p("You can see which of the videos has the most likes, 
             dislikes, and views!"),
      tags$h4("SEE TRENDING TOPICS"),
      tags$p("You can see the tags of trending categories and stay up to date
             with the latest topics!"),
      tags$h4("FIND THE MOST POPULAR CATEGORIES"), 
      tags$p("Get insight on what kind of videos are the hottest topics on
             YouTube!")
    
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
            "rating",
            "comments"
          )
        )
      ),

      # Main panel for the bar graph
      mainPanel(
        plotlyOutput("bar"),
        tags$hr(),
        tags$p("This bar graph shows the Top 25 Videos in a certain category
               according to a specific video statistic. The user is able to 
               choose which categories to display and the which statistic to
               organize it by. This allows the user to be know what types of
               videos get the most likes, dislikes, and views.")
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
        plotOutput("cloud"),
        tags$hr(),
        tags$p("The word cloud shows the most frequent tags of the trending 
               videos depending on category. It allows the user to know what
               topics in each category are most popular right now.")
      )
    )
  ),
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
          choices = categories_line,
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
        plotlyOutput("line"),
        tags$hr(),
        tags$p(
          "This bar graph shows the Top 25 Videos in a certain category 
          according to a specific video statistic. The user is able to choose 
          which categories to display and the which statistic to organize it 
          by. This allows the user to be know what types of videos get the 
          most likes, dislikes, and views."
        )
      )
    )
  )
))
