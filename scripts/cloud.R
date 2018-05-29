library(tm)
library(wordcloud)
library(memoise)
library(dplyr)
library(stringr)

source('analysis.R')
# Combine tags with the same category
Category <- function(type){
  category_tag <- new_data %>%select(category, tags) %>% group_by(category)
  tag <- category_tag %>% filter(category == type)
  combine_tag <- as.data.frame(unlist(tag$tags))
  names(combine_tag)[1] <- "tag"
  tag_count <- combine_tag %>% group_by(tag)%>% mutate(count = n())
  unique_tag <- unique(tag_count)
  
}
sample <- Category("Comedy")
# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(Category(type){
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(tag %in% unique_tag))
    stop("Unknown Category")
  type <- list(new_data$category)
  text <- readLines(sprintf("./%s.txt.gz", tags),
                    encoding="UTF-8")
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
            c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
   )
