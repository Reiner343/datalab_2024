
# load libraries

library(tidytext)
library(ggplot2)
library(dplyr)
library(gsheet)
library(wordcloud2)
library(sentimentr)
library(lubridate)

# Read in your survey data by running the following
Hidesurvey <- gsheet::gsheet2tbl('https://docs.google.com/spreadsheets/d/1W9eGIihIHppys3LZe5FNbUuaIi_tfdscIq521lidRBU/edit?usp=sharing')
  
# Take a look at the first few rows of the data. What is the unit of observation?
head(Hidesurvey)
  
# Create a variable named date_time in your survey data. This should be based on the Time stamp variable. Use the mdy_hms variable to created a “date-time” object.
Hidesurvey <- Hidesurvey %>% 
  mutate( date_time= mdy_hms(Hidesurvey$Timestamp))

# Create a visualization of the date_time variable.
ggplot(date = Hidesurvey, aes(x= date_time)) +
  geom_histogram()

# Create an object called sentiments by running the following
Hidesentiments <- get_sentiments('bing')

# Explore the sentiments object. How many rows? How many columns? What is the unit of observation.
ncol(Hidesentiments)
nrow(Hidesentiments)
# unit of observation is words
     
# Create an object named words by running the following
words <- Hidesurvey %>%
  dplyr::select(first_name,
                feeling_num,
                feeling) %>%
  unnest_tokens(word, feeling)

# Explore words. What is the unit of observation.
# unit of observation is names

# Look up the help documentation for the function wordcloud2. What does it expect as the first argument of the function?
# A data frame including word and freq in each column
  
# Create a dataframe named word_freq. This should be a dataframe which is conformant with the expectation of wordcloud2, showing how frequently each word appeared in our feelings.
word_freq <- words %>% 
  group_by(word) %>% 
  tally()

# Make a word cloud.
wordcloud2(data = word_freq)

# Run the below to create an object named sw.
Hidesw <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/stopwords.csv')

# What is the sw object all about? Explore it a bit.
# the sw object is all about words

# Remove from word_freq any rows in which the word appears in sw.

# Make a new word cloud.

# Make an object with the top 10 words used only. Name this object top10.

# Create a bar chart showing the number of times the top10 words were used.
# Run the below to join word_freq with sentiments.

# Now explore the data. What is going on?
  
# For the whole survey, were there more negative or positive sentiment words used?
  
# Create an object with the number of negative and positive words used for each person.

# In that object, create a new variable named sentimentality, which is the number of positive words minus the number of negative words.

# Make a histogram of sentimentality

# Make a barplot of sentimentality.
