rankhospital <- function(state, outcome, num = "best") {
  
  data <- read.csv("data/week3data/outcome-of-care-measures.csv") %>%
    select(State, 
           Hospital.Name,
           `heart attack` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
           `heart failure` = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
           `pneumonia` = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia") %>%
    pivot_longer(cols = 3:5, names_to = "type", values_to = "death_rate") %>%
    mutate(
      State = as.character(State),
      death_rate = as.numeric(as.character(death_rate)),
      Hospital.Name = as.character(Hospital.Name))
  
  states <- data %>% distinct(State) %>% pull()
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if (state %in% states & outcome %in% outcomes) {
    if (num == "best") {
      res <- data %>% 
        filter(State == state, type == outcome, death_rate != "Not Available") %>%
        arrange(death_rate, Hospital.Name) %>%
        slice(1) %>%
        pull(Hospital.Name)
    } else if (num == "worst") {
      res <- data %>% 
        filter(State == state, type == outcome, death_rate != "Not Available") %>%
        arrange(desc(death_rate), Hospital.Name) %>%
        slice(1) %>%
        pull(Hospital.Name)
    } else {
      res <- data %>% 
        filter(State == state, type == outcome, death_rate != "Not Available") %>%
        arrange(death_rate, Hospital.Name) %>%
        mutate(rating = row_number()) %>%
        filter(rating == num) %>%
        pull(Hospital.Name)
      
      res <- if (is_empty(res)) {
        NA
      } else {res}
      
    }
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
  return(res)
}

  
  