# Heike Joana Wege
# 13.-15.12.2017

# Datawrangling-Script for the IODS-Final-Assignment 

#Accessing the necessary libraries:

library(dplyr)
library(stringr)

# Choosing and loading the datasets "human development (hd)" and "gender inequality index (gii)":

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# taking a look at their structures and dimensions:

str(hd)
dim(hd)
# The dataset contains a total of 8 variables and 195 observations.
# The variables are: HDI.Rank, Country, Human.Development.Index..HDI., Life.Expectancy.at.Birth, Expected.Years.of Education, Mean.Years.of.Education, Gross.National.Income..GNI..per.Capita, GNI.per.Capita.Rank.Minus.HDI.Rank

str(gii)
dim(gii)
# The dataset contains a total 10 variables and 195 observations.
# The variables are: GII.Rank, Country, Gender.Inequality.Index..GII., Maternal.Mortality.Ratio, Adolescent.Birth.Rate, Percent.Representation.in.Parliament, Population.with.Secondary.Education..Female., Population.with.Secondary.Education..Male., Labour.Force.Participation.Rate..Female., Labour.Force.Participation.Rate..Male. 

#In order to continue it makes sense to shorten the names of the variables (the variable "Country" will not be changed):

# HDI.Rank - HDIR
colnames(hd)[1] <- "HDIR"
# Human.Development.Index..HDI. - HDI
colnames(hd)[3] <- "HDI"
# Life.Expectancy.at.Birth - Life_Exp
colnames(hd)[4] <- "Life_Exp"
# Expected.Years.of Education - Exp_Edu
colnames(hd)[5] <- "Exp_Edu"
# Mean.Years.of.Education - Mean_Edu
colnames(hd)[6] <- "Mean_Edu"
# Gross.National.Income..GNI..per.Capita - GNI
colnames(hd)[7] <- "GNI"
# GNI.per.Capita.Rank.Minus.HDI.Rank - Diff_GNI_HDI
colnames(hd)[8] <- "Diff_GNI_HDI"

# GII.Rank - RGII
colnames(gii)[1] <- "RGII"
# Gender.Inequality.Index..GII. - GII
colnames(gii)[3] <- "GII"
# Maternal.Mortality.Ratio - MMR
colnames(gii)[4] <- "MMR"
# Adolescent.Birth.Rate - ABR
colnames(gii)[5] <- "ABR"
# Percent.Representation.in.Parliament - PRP
colnames(gii)[6] <- "PRP"
# Population.with.Secondary.Education..Female. - sec_Edu_F
colnames(gii)[7] <- "sec_Edu_F"
# Population.with.Secondary.Education..Male - sec_Edu_M
colnames(gii)[8] <- "sec_Edu_M"
# Labour.Force.Participation.Rate..Female. - LF_F
colnames(gii)[9] <- "LF_F"
# Labour.Force.Participation.Rate..Male. - LF_M
colnames(gii)[10] <-"LF_M"

# Checking the new variable-names:
colnames(hd)
colnames(gii)

# The variable "Country" exists in both datasets, and can therefore ideally be used to combine the datasets into one.
fa_human <- inner_join(hd, gii, by = c("Country"))
dim(fa_human)
colnames(fa_human)
#The newly combined dataset now contains 195 observations (as before) and 17 variables (8 + 10 - 1xCountry)


