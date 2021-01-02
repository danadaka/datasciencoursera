## Write a function called rankall that takes two arguments: an outcome name 
## (outcome) and a hospital ranking (num).  The function reads the 
## outcome-of-care-measures.csv file and returns a 2-column data frame 
## containing the hospital in each state that has the ranking specified in num. 
## For example the function callrankall("heart attack", "best")would return a 
## data frame containing the names of the hospitals that are the best in their 
## respective states for 30-day heart attack death rates. The function should 
## return a value for every state (some may be NA). The first column in the 
## data frame is named hospital, which contains the hospital name, and the 
## second column is named state, which contains the 2-character abbreviation for 
## the state name.  Hospitals that do not have data on a particular outcome 
## should be excluded from the set of hospitals when deciding the rankings.



rankall <- function(outcome, num = "best") {
  
  suppressMessages(require(tidyverse))
  
  data <- read.csv("data/week3data/outcome-of-care-measures.csv") %>%
    select(
      State, 
      Hospital.Name,
      `heart attack` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
      `heart failure` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
      `pneumonia` = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia") %>%
    pivot_longer(cols = 3:5, names_to = "type", values_to = "death_rate") %>%
    filter( death_rate != "Not Available") %>%
    mutate(
      State = as.character(State),
      death_rate = as.numeric(as.character(death_rate)),
      Hospital.Name = as.character(Hospital.Name)) %>%
    group_by(State)
  
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if(outcome %in% outcomes) {
    data_filtered <- data %>% 
      filter(type == outcome) 
    
    states <- data_filtered %>%
      distinct(State) %>%
      arrange(State)
    
    result <- if (num == "best") {
      data_filtered %>% 
        arrange(death_rate, Hospital.Name) %>%
        slice(1) %>%
        select(Hospital.Name, State)
    } else if (num == "worst") {
      data_filtered %>% 
        arrange(desc(death_rate), Hospital.Name) %>%
        slice(1) %>%
        select(Hospital.Name, State)
    } else {
      data_filtered %>%
        arrange(death_rate, Hospital.Name) %>%
        mutate(rating = row_number()) %>%
        filter(rating == num) %>%
        select(Hospital.Name, State)
    }
    
    res <- states %>%
      left_join(result, by = "State") %>%
      select(Hospital_name, State)
    
  } else {
  stop("invalid outcome")
  } 
  geterrmessage()
  return(res)
}
  