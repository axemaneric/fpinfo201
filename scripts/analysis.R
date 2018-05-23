library(dplyr)
library(jsonlite)
library(httr)

data <- fromJSON("../data/US_category_id.json")
data <- flatten(data[["items"]]) %>% 
  select(id, snippet.title) %>% 
  rename(category_id = id, Category = snippet.title)
data$category_id <- as.integer(data$category_id)
US_videos <- read.csv("../data/USvideos.csv", stringsAsFactors = FALSE)
new_data <- left_join(US_videos, data, by = "category_id")
l <- as.character(data$Category)
names(l) <- data$category_id

