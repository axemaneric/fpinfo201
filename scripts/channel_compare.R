library(plotly)
library(stringr)
library(dplyr)
library(rlang)

build_bar <- function(data, yvar = "", cat = "") {
  data <- data %>%
    arrange(desc(data[, yvar])) %>%
    filter(category == cat) %>%
    distinct(title, .keep_all = TRUE) %>%
    head(25)

  data$title <- factor(data$title, levels = data$title)
  options <- list(
    "likes" = "MOST LIKED",
    "dislikes" = "MOST DISLIKED",
    "views" = "MOST VIEWED",
    "rating" = "HIGHEST RATING",
    "comments" = "MOST COMMENTS"
  )

  link <- paste0("<a href = 'https://www.youtube.com/watch?v=", data$video_id, "'>Click Me!</a>")

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
