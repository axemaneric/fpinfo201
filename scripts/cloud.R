library(wordcloud)
library(dplyr)
library(stringr)
library(tm)

# Takes in data frame and category type
# returns wordcloud
build_cloud <- function(data, type) {
  # data wrangling
  category_tag <- data %>% 
    select(category, tags) %>% 
    group_by(category)
  tag <- category_tag %>% filter(category == type)
  combine_tag <- as.data.frame(unlist(tag$tags))
  names(combine_tag)[1] <- "tag"
  tag_count <- combine_tag %>%
    group_by(tag) %>%
    mutate(count = n()) %>%
    arrange(-count)
  unique_tag <- unique(tag_count)
  
  # color and plot
  pal1 <- brewer.pal(8, "Set1")
  wordcloud(
    words = unique_tag$tag, freq = unique_tag$count, min.freq = 100,
    random.order = F, random.color = F, colors = pal1, rot.per = .1
  )
}
