library(tidyverse)

--------------------------------------------------------------------------------

data(iris) 

# What is the mean of 'Sepal.Length' for the species virginica?

iris %>% 
  filter(Species == "virginica") %>%
  summarise(mean = mean(Sepal.Length),
            mean_round = round(mean))

# Return a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 
# 'Petal.Length', and 'Petal.Width'?

apply(iris[, 1:4], 2, mean)

--------------------------------------------------------------------------------

data(mtcars)

# Calculate the average miles per gallon (mpg) by number of cylinders 
# in the car (cyl)?

with(mtcars, tapply(mpg, cyl, mean))

sapply(split(mtcars$mpg, mtcars$cyl), mean)

# What is the absolute difference between the average horsepower of 
# 4-cylinder cars and the average horsepower of 8-cylinder cars?

abs(mean(mtcars[mtcars$cyl == 4, ]$hp) - mean(mtcars[mtcars$cyl == 8, ]$hp))

--------------------------------------------------------------------------------


