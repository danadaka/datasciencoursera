# Write a function that reads a directory full of files and reports the number 
# of completely observed cases in each data file. The function should return 
# a data frame where the first column is the name of the file and the second 
# column is the number of complete cases.

library(tidyverse)

complete <- function(directory, id = 1:332) {
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  
  datasets <- data.frame()
  
  for(i in id) {
    dataset <- read.csv(filenames[i])
    datasets <- rbind(datasets, dataset)
  }
  
  datasets %>% 
    filter(!is.na(sulfate), !is.na(nitrate)) %>%
    count(ID) 
}

# Test questions:

complete("data/specdata", c(2, 4, 8, 10, 12))  
complete("data/specdata", 2:1)  

