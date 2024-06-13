# cleaning messy data

# set working directory
setwd("~/Desktop/reiner_datalab/datalab_2024/Cleaning messy data")

library(tidyverse)
library(dplyr)
library(readr)

whales_dives_messy <- read_csv("whales_dives_messy.csv")
whale_dives <- read_csv("whales_dives.csv")

# change year '15 to '2015

whale_dives_ <- whales_dives_messy %>% 
  mutate(YEAR = case_when(YEAR==(15) ~ 2015,
  TRUE ~ YEAR  # keep the value unchanged if it doesn't match any condition
))

# rename the columns in the messy data set
names(whale_dives_) <- c("species", "behavior", "prey.volume",                                     "prey.depth",
                                 "dive.time", "surface.time", "blow.                                       .interval",
                                 "blow.number", "year", "month", "day",                                    "sit")

# need to rename month to have 0 in front and day with 0 before number of date if before the 10th

#Changing month column to add a 0 in front of single character months
whale_dives_ <- whale_dives_%>%
  mutate( Month=str_pad(whale_dives_$month,width=2,side="left",pad="0"), Day=str_pad(whale_dives_$day,width=2,side="left",pad="0"))

# remove sighting from the sit column
whale_dives_ <- whale_dives_ %>% 
  mutate(sit = str_remove(whale_dives_$sit,"Sighting\\s*"))

# paste columns together
# paste0 pastes something but removing any space
whale_dives_$id <- paste0(whale_dives_$year, whale_dives_$month,
  whale_dives_$day, whale_dives_$sit)

#cuts off every character in behavior after the first ( so everything will become F and O)
# sub string is used to remove a character from the text
whale_dives_$behavior <- substr(whale_dives_$behavior, 1, 1)

#renames F to FEED and O to OTHER
whale_dives_ <- whale_dives_ %>% 
  mutate(behavior = case_when(
  behavior %in% c("F") ~ "FEED",
  behavior %in% c("O") ~ "OTHER",
  TRUE ~ behavior  # keep the value unchanged if it doesn't match any condition
))

# but how to remove columns that we wanted to MERGE...? drop columns
whale_dives_ <- subset(whale_dives_, select = -c(year, month, day, sit, Month, Day))

whale_dives_ <- subset(whale_dives_, select = -c( Month, Day))

## removes all rows with NA and then keeps distinct observations
# distinct removes all duplicates and keeps one
whale_dives_<- na.omit(whale_dives_)
whale_dives_ <- whale_dives_%>% 
  distinct()

#corrects misspellings in species column
whale_dives_ <- whale_dives_ %>% 
  mutate(species = case_when(
  species == "FinW" ~ "FW",
  species == "FinWhale" ~ "FW",
  species == "Hw" ~ "HW",
  TRUE ~ species  # Keep other values unchanged
))

# removes 2 observations that were called finderbender
# because they do not show up in the clean version
whale_dives_ <- whale_dives_ %>% 
  filter(id!=20150915507)
whale_dives_ <- whale_dives_ %>% 
  filter(id!=20150911503)

# need to convert our id column in ours to be numeric, because it is originally a character value
whale_dives_$id <- as.numeric(whale_dives_$id)

# find what is not matching
all.equal(whale_dives, whale_dives_)

