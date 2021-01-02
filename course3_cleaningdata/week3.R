

library(tidyverse)

uscom <- read.csv("./data/uscommunities.csv")

uscom %>%
  mutate(agricultureLogical = if_else((ACR == 3 & AGS == 6), TRUE, FALSE), 
         row = row_number()) %>% 
  filter(agricultureLogical == TRUE) %>%
  select(row) %>%
  head(3)

uscom %>% 
  mutate(row = row_number()) %>%
  filter(ACR == 3 & AGS == 6)


strsplit(names(uscom), "wgtp")[123]

-------------------------------------------------------------------------------

gurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(gurl, destfile = "./data/gpdus.csv")
gdpus <- read.csv("./data/gpdus.csv")

sub("\\,", "\\", gdpus$X.3)

gdpus %>%
  mutate(X.3 = str_remove_all(X.3, "\\,"),
         X.3 = as.numeric(X.3)) %>%
  summarise(mean = mean(X.3, na.rm = TRUE))
