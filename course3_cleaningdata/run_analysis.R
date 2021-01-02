
library(tidyverse)

read_delim(delim = "\ ")


features <- 
  read_delim(here::here("data/uci_har_dataset/features.txt"),
             delim = " ", 
             col_names = FALSE) %>%
  rbind(tibble(X1 = c(562, 563), X2 = c("activity", "subject"))) %>%
  pull(X2)

activity_names <- 
  read_delim(here::here("data/uci_har_dataset/activity_labels.txt"),
             delim = " ", 
             col_names = FALSE)

x_test <- 
  read_delim(here::here("data/uci_har_dataset/test/X_test.txt"), 
             delim = " ", col_names = FALSE) %>% 
  mutate(across(where(is_character), as.double))

x_train <- 
  read_delim(here::here("data/uci_har_dataset/train/X_train.txt"), 
             delim = " ", col_names = FALSE) %>% 
  mutate(across(where(is_character), as.double))

y_test <- 
  read_delim(here::here("data/uci_har_dataset/test/y_test.txt"), 
             delim = " ", col_names = FALSE) %>%
  full_join(activity_names, by = "X1") %>%
  select(X2)

y_train <- 
  read_delim(here::here("data/uci_har_dataset/train/y_train.txt"), 
             delim = " ", col_names = FALSE) %>%
  full_join(activity_names, by = "X1") %>%
  select(X2)

subject_test <- 
  read_delim(here::here("data/uci_har_dataset/test/subject_test.txt"), 
             delim = " ", col_names = FALSE) 

subject_train <- 
  read_delim(here::here("data/uci_har_dataset/train/subject_train.txt"), 
             delim = " ", col_names = FALSE)  

test <- x_test %>%
  cbind(y_test, subject_test)

train <- x_train %>%
  cbind(y_train, subject_train)

dataset <- 
  train %>%
  rbind(test)

colnames(dataset) <- features

dataset_mean_std <-
  dataset %>%
  select(contains(c("mean", "std", "activity", "subject")))

summarised_dataset <- 
  dataset_mean_std %>% 
  group_by(subject, activity) %>% 
  summarise(across(contains(c("mean", "std")), mean, .names = "avg_{col}")) %>%
  ungroup()

summarised_dataset %>%
  write.table(file = "course3_cleaningdata/uci_har_summarised.txt", 
              row.names = FALSE)
