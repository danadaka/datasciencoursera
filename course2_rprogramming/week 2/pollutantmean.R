# The task is 
# "Write a function named 'pollutantmean' that calculates the mean of a 
# pollutant (sulfate or nitrate) across a specified list of monitors. The 
# function 'pollutantmean' takes three arguments: 'directory', 'pollutant', 
# and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that 
# monitors' particulate matter data from the directory specified in the 
# 'directory' argument and returns the mean of the pollutant across all of 
# the monitors, ignoring any missing values coded as NA."

pollutantmean <- function(directory, pollutant, id = 1:332) {
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  
  datasets <- data.frame()
  
  for(i in id) {
    dataset <- read.csv(filenames[i])
    
    datasets <- rbind(datasets, dataset)
  }
  
  mean(datasets[,pollutant], na.rm = TRUE)
}

pollutantmean("data/specdata", "sulfate", id = 1:10)

##############################################################

datasets <- data.frame()

