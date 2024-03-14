# Excercise 1 ----
# Create a vector consisting of the sum, maximum, minimum of the numbers 3, 6, 9

# Exercise 2 ----
# For the following data frame, create a column with an index for each row
df1 = data.frame(
  first_col = c(1112, 123143, 3554, 1245, 6346)
  ,Name = c("Kris", "Tom", "Ella", "Cloe", "John")
)

# Exercise 3 ----
# For df1 from the previous task, add a column containing information whether the row is even or odd

# Task 4 ----
# Select the last 2 lines of df1

# Task 5 ----
# Combine text1 and text2, convert uppercase letters to lowercase and count the number of characters in the text
text1 = "Marketing CaMpaign cost 1 BLN dollars, which was higher than in 2017"
text2 = "It is important to reduce the costs by 30%,,, next year"

# Task 6 ----
# Build a new dataframe that will look like this:

##   Age   Name Gender
## 1  22  James      M
## 2  25 Mathew      M

# Task 7 ----
# Calculate the sum of the two vectors below. What will be the result?
x = c(2, 4, 6, 8)
y = c(TRUE, TRUE, FALSE, TRUE)

# Task 8 ----
# What will be the dimension/size of the vector below?
x = c(0:11)

# Task 9 ----
# Check if the vector below is a numeric type and display what type of data is in the vector.
x = c('blue', 10, 'green', 20)

# Task 10 ----
# Generate a vector from 23, 22.5, 22, 21.5, ..., 15

# Task 11 ----
# Create the vectors below using sequential and/or repeating functions
c(1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4)
c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4)

# Task 12 ----
# Filter out empty values from the vector below
x = c(NA, 3, 14, NA, 33, 17, NA, 41)

# Task 13 ----
# Filter out rows that contain empty values.
df = data.frame(
  Name = c(NA, "Kris", "John", NA, "Alex")
  ,Sales = c(15, 18, 21, 56, 60)
  ,Price = c(34, 52, 21, 44, 20)
) 

# Task 14 ----
# Filter out columns that contain empty values.

# Task 15 ----
# How many characters are in the vector below
zz = c("seaside's", "Best ")

# Task 16 ----
# Create a caption: "007 James, Bond" based on the vectors below
apple = "James"
big_number = "Bond"
some_txt = 007

# Task 17 ----
# Write a function that returns the sum of 2 values and checks whether the 2 arguments are digits.

# Task 18 ----
# Add the following vectors to the data frame from exercise 2.
x = c( 346, "Don") 
y = c( 369, "Katy")

# Task 19 ----
# Create an apply function that will count the number of even digits in rows and columns
df2 = data.frame(col1 = c(1, 2, 3),
                  col2 = c(4, 5, 6),
                  col3 = c(7, 8, 9),
                  col4 = c(10, 1, 1))

# Task 20 ----
# Calculate the sum of each matrix in the list and calculate the sum for all sums from individual lists.
A = matrix(1:9, 3, 3)
B = matrix(4:15, 4, 3)
C = matrix(8:10, 3, 2)
MyList = list(A, B, C) 
