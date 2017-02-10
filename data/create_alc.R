# Otso Perakyla, 10.2.2017: IODS exercise 3

# set working directory
setwd("/Users/otsopera/Documents/IODS/IODS-project/data")


# clear all variables possibly left over from previous sessions
rm(list = ls())

# library(dplyr) # for data wrangling

math=read.table("./student/student-mat.csv",sep=";",header=TRUE)
por=read.table("./student/student-por.csv",sep=";",header=TRUE)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por=merge(math,por,by=join_by,suffix = c('.math','.por'))


print(nrow(math_por)) # 382 students

str(math_por) # 53 variables
dim(math_por)

alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

rm(list = c('math','por','two_columns','math_por')) # clear the individual variables from memory

# glimpse at the new combined data
glimpse(alc)


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)



# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)




# glimpse at the new combined data
glimpse(alc)


write.table(alc, file = "alc_students.txt", row.names = F)

head(read.table("alc_students.txt"))
# seems to work

