library(wordcloud)
library(dplyr)
library(stringr)
library(tm)

source('analysis.R')
# Combine tags with the filtered category
build_cloud <- function(data, type) {
  category_tag <- data %>%select(category, tags) %>% group_by(category)
  tag <- category_tag %>% filter(category == type)
  combine_tag <- as.data.frame(unlist(tag$tags))
  names(combine_tag)[1] <- "tag"
  tag_count <- combine_tag %>% group_by(tag)%>% mutate(count = n()) %>% 
    arrange(-count)
  unique_tag <- unique(tag_count)
  pal1 <- brewer.pal(8,"Set1")
  wordcloud(words = unique_tag$tag, freq = unique_tag$count, min.freq = 100, 
            random.order = F, random.color = F, colors = pal1, rot.per = .1)
}
test <- build_cloud(new_data, "Comedy")


