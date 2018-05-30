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

# Filter out videos we can't use (videos without comments, ratings, or deleted videos)
# Select only columns that we need
new_data <- new_data %>% 
  filter(comments_disabled == 'False') %>%
  filter(ratings_disabled == 'False') %>%
  filter(video_error_or_removed == 'False') %>%
  select(video_id, trending_date, title, channel_title, category, tags, 
         views, likes, dislikes, comment_count, thumbnail_link)

# Change the format of date
new_data$trending_date <- paste0("20",new_data$trending_date)
new_data$trending_date <- as.Date(new_data$trending_date, "%Y.%d.%m")


# Write new_data to data folder
write.csv(new_data, "../data/new_data.csv")
