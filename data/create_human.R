# Otso Perakyla, 17.2.2017: IODS exercise 4

# set working directory
if (Sys.info()['sysname'] == 'Windows') {
  setwd("D:/Documents/Courses/IODS/IODS-project/data")
} else {
  setwd("/Users/otsopera/Documents/IODS/IODS-project/data")
}



# clear all variables possibly left over from previous sessions
rm(list = ls())

library(dplyr) # for data wrangling



# read the "Human development" and "Gender inequality" data from the given url

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")



# check the structure of the data
str(hd)
dim(hd)
# data includes 8 vars (incl. HDI rank and Country), 195 observations: dim gives only dimensions, str gives var names and first values as well

str(gii)
dim(gii)
# data includes 10 vars (incl. gender inequality rank and country), 195 observations: dim gives only dimensions, str gives var names and first values as well


# rename the variables to more handy values. First get the current names, then change them accordingly.
# done like this in order not to mess up the order of the names

names_hd = names(hd) # get names
names_hd[names_hd == "HDI.Rank"] <- "HDI_rank"
names_hd[names_hd == "Human.Development.Index..HDI."] <- "HDI"
names_hd[names_hd == "Life.Expectancy.at.Birth"] <- "life_exp_yrs"
names_hd[names_hd == "Expected.Years.of.Education"] <- "exp_edu_yrs"
names_hd[names_hd == "Mean.Years.of.Education"] <- "mean_edu_yrs"
names_hd[names_hd == "Gross.National.Income..GNI..per.Capita"] <- "GNI"
names_hd[names_hd == "GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNI_minus_HDI_ranks"
names(hd) = names_hd; # set names



names_gii = names(gii)
names_gii[names_gii == "GII.Rank"] <- "GII_rank"
names_gii[names_gii == "Gender.Inequality.Index..GII."] <- "GII"
names_gii[names_gii == "Maternal.Mortality.Ratio"] <- "maternal_mortality"
names_gii[names_gii == "Adolescent.Birth.Rate"] <- "adolescent_birth_rate"
names_gii[names_gii == "Percent.Representation.in.Parliament"] <- "parl_represent"
names_gii[names_gii == "Population.with.Secondary.Education..Female."] <- "sec_edu_women"
names_gii[names_gii == "Population.with.Secondary.Education..Male."] <- "sec_edu_men"
names_gii[names_gii == "Labour.Force.Participation.Rate..Female."] <- "labour_partic_women"
names_gii[names_gii == "Labour.Force.Participation.Rate..Male."] <- "labour_partic_men"

names(gii) = names_gii



# create two new variables to the gender inequality set
gii <- mutate(gii, gender_ratio_sec_edu = sec_edu_women/sec_edu_men)
gii <- mutate(gii, gender_ratio_labour_force = labour_partic_women/labour_partic_men)


# use country as identifier
join_by <- c("Country")

# join the two datasets by the selected identifiers
human <- inner_join(gii, hd, by = join_by, suffix = c('.gii','.hd'))




# save data to txt
write.table(human, file = "human.txt", row.names = F)





head(read.table("human.txt"))
# seems to work



# tidyr package and human are available

# access the stringr package
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and save it in the human data


human <- mutate(human, GNI = as.numeric(str_replace(human$GNI, pattern=",", replace ="")))
summary(human$GNI)


