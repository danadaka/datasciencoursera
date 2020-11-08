## Write a function called rankhospital that takes three arguments:  
## the 2-character abbreviated name of astate (state), an outcome (outcome), 
## and the ranking of a hospital in that state for that outcome (num). 
## The function reads the outcome-of-care-measures.csv file and returns 
## a character vector with the name of the hospital that has the ranking 
## specified by the num argument. 
##
## The num argument can take values “best”, “worst”,  or an integer indicating 
## the ranking (smaller numbers are better).  If the number given by num is 
## larger than the number of hospitals in that state, then the function should 
## return NA. Hospitals that do not have data on a particular outcome should 
## be excluded from the set of hospitals when deciding the rankings.
## 
## The function should check the validity of its arguments.  If an invalid 
## state value is passed to rankhospital, the function should throw an error 
## via the stop function with the exact message “invalid state”.  If an 
## invalid outcome value is passed to rankhospital, the function should throw 
## an error via the stop function with the exact message “invalid outcome”


rankhospital <- function(state, outcome, num = "best") {
  
  suppressMessages(require(tidyverse))
  
  data <- read.csv("data/week3data/outcome-of-care-measures.csv") %>%
    select(
      State, 
      Hospital.Name,
      `heart attack` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
      `heart failure` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
      `pneumonia` = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia") %>%
    pivot_longer(cols = 3:5, names_to = "type", values_to = "death_rate") %>%
    filter(death_rate != "Not Available") %>%
    mutate(
      State = as.character(State),
      death_rate = as.numeric(as.character(death_rate)),
      Hospital.Name = as.character(Hospital.Name))
  
  states <- data %>% distinct(State) %>% pull()
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if (state %in% states & outcome %in% outcomes) {
    if (num == "best") {
      res <- data %>% 
        filter(State == state, type == outcome) %>%
        arrange(death_rate, Hospital.Name) %>%
        slice(1) %>%
        pull(Hospital.Name)
    } else if (num == "worst") {
      res <- data %>% 
        filter(State == state, type == outcome) %>%
        arrange(desc(death_rate), Hospital.Name) %>%
        slice(1) %>%
        pull(Hospital.Name)
    } else {
      res <- data %>% 
        filter(State == state, type == outcome) %>%
        arrange(death_rate, Hospital.Name) %>%
        mutate(rating = row_number()) %>%
        filter(rating == num) %>%
        pull(Hospital.Name)
      
      res <- if (is_empty(res)) {
        NA
      } else {res}
    }
  } else if (state %in% states & (!outcome %in% outcomes)) {
    stop("invalid outcome")
  } else if ((!state %in% states) & outcome %in% outcomes) {
    stop("invalid state")
  } else {
    stop("invalid state and outcome")
  }
  
  geterrmessage()
  return(res)
}

  
  