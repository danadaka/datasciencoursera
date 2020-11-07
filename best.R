
## Write a function called best that take two arguments:  the 2-character 
## abbreviated name of a state and anoutcome name.  The function reads 
## the outcome-of-care-measures.csv file and returns a character vector with  
## the  name  of  the  hospital  that  has  the  best  (i.e.   lowest)  30-day  
## mortality  for  the  specified  outcome in that state.  The hospital name is 
## the name provided in the Hospital.Name variable.  The outcomes can be one of 
## “heart attack”, “heart failure”, or “pneumonia”.  Hospitals that do not have 
## data on a particular outcome should be excluded from the set of hospitals 
## when deciding the rankings.

## If there is a tie for the best hospital for a given outcome, then the 
## hospital names should be sorted in alphabetical order and the first hospital 
## in that set should be chosen (i.e.  if hospitals “b”, “c”,and “f” are tied 
## for best, then hospital “b” should be returned).

best <- function(state, outcome) {
  
  data <- read.csv("data/week3data/outcome-of-care-measures.csv") %>%
    select(State, 
           Hospital.Name,
           `heart attack` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
           `heart failure` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
           `pneumonia` = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia") %>%
    pivot_longer(cols = 3:5, names_to = "outcome", values_to = "death_rate") %>%
    mutate(
      State = as.character(State),
      hospital = as.character(Hospital.Name))
  
  states <- data %>% distinct(State) %>% pull()
  outcomes <- c("heart attack”, “heart failure”, “pneumonia")
  
  result <- data %>% 
    filter(State == state, outcome == outcome) %>%
    arrange(death_rate, hospital) %>%
    slice(1) %>%
    pull(hospital)
  
  if (is_empty())
  
  
  if (state %in% states & outcome %in% outcomes) {
    result <- data %>% 
      filter(State == state, outcome == outcome) %>%
      arrange(death_rate, hospital) %>%
      slice(1) %>%
      pull(hospital)
    
    return(result)
  } else if (state %in% states & (!outcome %in% outcomes)) {
    stop()
    geterrmessage("outcome is invalid") 
  } else if ((!state %in% states) & outcome %in% outcomes) {
    stop()
    geterrmessage("state is invalid")
  } else {
    stop()
    geterrmessage("both state and outcome are invalid")
  }

}

best("AL", "heart failure")

data %>% 
  filter(State == "SC", outcome == "heart attack") %>%
  arrange(death_rate, hospital) %>%
  slice(1) %>%
  pull(hospital)


data %>% str()
