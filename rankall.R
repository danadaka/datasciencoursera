
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
      left_join(result, by = "State")
    
  } else {
  stop("invalid outcome")
  } 
  geterrmessage()
  return(res)
}
  