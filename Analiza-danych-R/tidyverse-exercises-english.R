library(tidyverse)
library(gapminder)
data(mtcars)

# Exercise 1 ----
# Filter cars that have at least 100 HP and can travel a maximum of 20 miles per gallon of gas
# Select only columns: disp, hp, drat, wt

# Exercise 2 ----
# Calculate the average horsepower and average miles per gallon of gasoline depending on the number of cylinders

# Exercise 3 ----
# Calculate the average engine power of cars that can travel more than 20 miles on one gallon of gasoline

# Exercise 4 ----
# Calculate the average fuel consumption per liter/100 km by gearbox type

data(gapminder)

# Exercise 5 ----
# Create a data frame showing average life expectancy by continent for the years 1957 and 2007

# Exercise 6 ----
# Create a new column that calculates the population density (population/area) for each country

# Exercise 7 ----
# Create a new column that categorizes each country's population size into one of three groups:
# "small" (population < 10 million)
# "medium" (population between 10 and 100 million)
# "large" (population > 100 million)

# Exercise 8 ----
# Convert the continent column to factor and change the order of the levels

# Exercise 9 ----
# Create a new column that shows the percentage change in life expectancy for each country between 1952 and 2007

# Exercise 10 ----
# Process the gapminder data set so that each row represents one year, each column represents one continent, and the values are the life expectancy for each continent in a given year
# year Africa Americas  Asia Europe Oceania
# <int>  <dbl>    <dbl> <dbl>  <dbl>   <dbl>
# 1  1952   39.1     53.3  46.3   64.4    69.3
# 2  1957   41.3     56.0  49.3   66.7    70.3
# 3  1962   43.3     58.4  51.6   68.5    71.1
# 4  1967   45.3     60.4  54.7   69.7    71.3
# 5  1972   47.5     62.4  57.3   70.8    71.9
# 6  1977   49.6     64.4  59.6   71.9    72.9
# 7  1982   51.6     66.2  62.6   72.8    74.3
# 8  1987   53.3     68.1  64.9   73.6    75.3
# 9  1992   53.6     69.6  66.5   74.4    76.9
# 10  1997   53.6     71.2  68.0   75.5    78.2
# 11  2002   53.3     72.4  69.2   76.7    79.7
# 12  2007   54.8     73.6  70.7   77.6    80.7

# Exercise 11 ----
# Create a decade column based on the year column

# Exercise 12 ----
# Create a new column that contains the number of years since the first observation for each country in the dataset

# Exercise 13 ----
# Create a new dataset that contains only South American countries, sorted by population growth (pop) between 1952 and 2007

# Exercise 14 ----
# Create a new dataset that only contains countries with two-word names

# Exercise 15 ----
# Create a new dataset that only contains countries whose name starts with the letter "M" and ends with "a"

# Exercise 16 ----
# Create a new dataset that includes only countries whose population exceeded 50 million at any time between 1952 and 2007