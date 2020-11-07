# Write a function that takes a directory of data files and a threshold for 
# complete cases and calculates the correlation between sulfate and nitrate for 
# monitor locations where the number of completely observed cases (on all 
# variables) is greater than the threshold. The function should return a vector 
# of correlations for the monitors that meet the threshold requirement. If no 
# monitors meet the threshold requirement, then the function should return 
# a numeric vector of length 0. 

corr <- function(directory, threshold = 0) {
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  
  ids <- complete(directory) %>%
    filter(n > threshold) %>%
    pull(ID)
  
  cr <- integer(0)
  
  if (is_empty(ids)) {
    return(cr)
  } else {
    for (i in ids) {
    
      need <- filenames[i] %>%
        read.csv() %>%
        filter(!is.na(sulfate), !is.na(nitrate))
      
      coor <- cor(need$sulfate, need$nitrate)
      
      cr <- c(cr, coor)
    }
  }
  return(cr)
}
