# set up libraries and source data analysis file
library(plotly)
library(dplyr)

# core function that creates an adaptive bar plot
# takes in a dataframe 'data'; a y-variable component yvar; category list 'cat'
build_bar <- function(data, yvar = "", cat = "") {
  
  # filter and select top 25 videos that match inputs
  data <- data %>%
    arrange(desc(data[, yvar])) %>%
    filter(category == cat) %>%
    distinct(title, .keep_all = TRUE) %>%
    head(25)

  # to keep order requires factored video title names
  data$title <- factor(data$title, levels = data$title)
  
  # title options
  options <- list(
    "likes" = "MOST LIKED",
    "dislikes" = "MOST DISLIKED",
    "views" = "MOST VIEWED",
    "rating" = "HIGHEST RATING",
    "comments" = "MOST COMMENTS"
  )

  # generate link for each featured video
  link <- paste0(
    "<a href = 'https://www.youtube.com/watch?v=",
    data$video_id, "'>Click Me!</a>"
  )

  # core plotly driver plot function
  # colors according to categories
  p <- plot_ly(data,
    x = ~ title,
    y = data[, yvar], type = "bar",
    colors = "Set2",
    color = ~ category,
    text = link,
    textposition = "auto"
  ) %>%
    layout(
      yaxis = list(title = toupper(yvar)),
      xaxis = list(title = "VIDEO"),
      title = toupper(paste("Top 25", options[yvar], "Videos"))
    )
  p
}
