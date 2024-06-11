# load libraries

library(babynames)
library(ggplot2)
library (dplyr)
library(tidyverse)

# make an object called bb_names

bb_names <- babynames

# Create a histogram of the name Marie in 1982.
marie_1982 <- bb_names %>% 
  filter ( name == "Marie" , year >= 1982) %>% 
  filter( sex == "F")

ggplot( data = marie_1982, aes( x= year, y=n)) +
  geom_line()
        
# Create a line plot for proportion of the name Joe, colored by sex. Make the lines a bit thicker and more transparent.
Joe <- bb_names %>% 
filter ( name == "Joe" )

# Add new x and y axis labels
ggplot( data = Joe, aes( x= year, y=prop, color= sex)) +
  geom_line( size = 1.5, alpha = 0.5) +
  labs (x = "Year",
        y = "proportion",
        title = "Graph of year against proportion")

# Create a bar chart of the ten most popular female names in 2002

Popular_female_names <- bb_names %>% 
  filter ( year == 2002 ) %>% 
  filter( sex == "F") %>%
  arrange( desc(n)) %>%
  head(10)

ggplot( data= Popular_female_names, aes( x=name, y=n )) +
  geom_col()

# Make the bars transparent and filled with the color blue.

ggplot( data= Popular_female_names, aes( x=name, y=n )) +
  geom_col(size = 1.5, alpha = 0.5, fill= "blue")


# Create a new data set called the_nineties that only contains years from the 1990s.
the_nineties <- bb_names %>% 
  filter(year <= 1999 & year >= 1990)
  

# Save this dataset to your repository (use write.csv()).

write_csv(the_nineties, file = 'bbnames_nineties.csv')
# Add, commit, and push your files to GitHub.