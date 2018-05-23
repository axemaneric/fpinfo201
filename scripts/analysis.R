library(dplyr)
library(jsonlite)
library(httr)

# Convert JSON into data frame (Category ID to Category conversion)
data <- fromJSON("../data/US_category_id.json")
data <- flatten(data[["items"]]) %>% 
  select(id, snippet.title) %>% 
  rename(category_id = id, category = snippet.title)

# Convert category id from char to int
data$category_id <- as.integer(data$category_id)

# Read in data of Top 200 US Videos
US_videos <- read.csv("../data/USvideos.csv", stringsAsFactors = FALSE)

# Join `US_videos` with `data` by category id. Adds categories to the videos
new_data <- left_join(US_videos, data, by = "category_id")

# Split the tags into a list
new_data$tags <- as.list(strsplit(new_data$tags, "|", fixed = T))
