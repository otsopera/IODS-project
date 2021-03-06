# Otso Per�kyl�, 3.2.2017: IODS exercise 2

# set working directory
setwd("D:/Documents/Courses/IODS/IODS-project/data/")


# clear all variables possibly left over from previous sessions
rm(list = ls())

library(dplyr) # for data wrangling


# read the "Learning 2014" data from the give url
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# check the structure of the data
str(lrn14)
dim(lrn14)
# data includes 60 vars (incl. age, attitude, points & gender), 183 observations: dim gives only dimensions, str gives var names and first values as well

# define questions included in the composite variables
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude/10

# select columns for the analysis dataset
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
lrn14_analysis <- select(lrn14, one_of(keep_columns))

str(lrn14_analysis)

# select rows where points is greater than zero
lrn14_analysis <- filter(lrn14_analysis, Points > 0)


str(lrn14_analysis)

write.table(lrn14_analysis, file = "learning2014.txt", row.names = F)





head(read.table("learning2014.txt"))
# seems to work

