# Heike Joana Wege
# 14.-15.12.2017
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



# creating new variables by combining sec_Edu_F & sec_Edu_M, as well as LF_F & LF_M:
sec_Edu <- gii$sec_Edu_F/gii$sec_Edu_M
LF <- gii$LF_F/gii$LF_M

# inclusion in dataset:
gii$sec_Edu <- sec_Edu
gii$LF <- LF

colnames(gii)



# The variable "Country" exists in both datasets, and can therefore ideally be used to combine the datasets into one.
fa_human <- inner_join(hd, gii, by = c("Country"))
dim(fa_human)
colnames(fa_human)
# The newly combined dataset now contains 195 observations (as before) and 17 variables (8 + 10 - 1xCountry)



# Setting the working directory to the data-folder within the IODS-final folder:
setwd("C:\\Users\\Ani\\Documents\\GitHub\\IODS-final")

# Saving the dataset:
write.csv(fa_human, file = "C:\\Users\\Ani\\Documents\\GitHub\\IODS-final\\fa_human.csv")

#The dataset with this number of variables now contains quite a number of variables. It therefore makes sense to "drop" those that do not serve the purpose of this project.

fa_human <- read.csv("C:\\Users\\Ani\\Documents\\GitHub\\IODS-final\\fa_human.csv")


# Looking at the variable GNI (as I remember from exercise 5 that it was not numeric):
summary(fa_human$GNI)
# The variable is represented by characters and would need to be numeric for further use.

# Changing the variable to numeric:
str_replace(fa_human$GNI, pattern = ",", replace = "") %>% as.numeric(fa_human$GNI)
fa_human$GNI <- as.numeric(fa_human$GNI)
summary(fa_human$GNI)



# Excluding the unnecessary variables:

# 1. by defining the columns that need to be kept:
keep <- c("Country", "Life_Exp", "Exp_Edu", "GNI", "MMR", "ABR", "PRP", "sec_Edu", "LF")

# 2. by using the dplyr-select function:
fa_human <- dplyr::select(fa_human, one_of(keep))

# checking the variables:
glimpse(fa_human)
# For the time being, I have 195 observations and 9 variables.



# checking for missing data:
data.frame(fa_human[-1], comp = complete.cases(fa_human))

fa_human <- filter(fa_human,complete.cases(fa_human))

data.frame(fa_human[-1], comp = complete.cases(fa_human))



# As the final seven "Country" observations are regions, I will exclude the rows belonging to them:
fa_human$Country
last <- nrow(fa_human) - 7
fa_human <- fa_human[1:last,]
fa_human$Country



# Defining countrynames as rownames:
rownames(fa_human) <- fa_human$Country

#removing the variable "Country" as their identification as the rownmanes should suffice:
fa_human <- dplyr::select(fa_human, -Country)
colnames(fa_human)
## the variable has been removed.



# sorting the dataset by GNI:

## printing the column fa_human$GNI:
fa_human$GNI
## sorting rows by GNI using dplyr::arrange:
dplyr::arrange(fa_human, -GNI)



# renewed setting the working directory to the data-folder within the IODS-final folder:
setwd("C:\\Users\\Ani\\Documents\\GitHub\\IODS-final")

# renewed saving the dataset:
write.table(fa_human, file = "C:\\Users\\Ani\\Documents\\GitHub\\IODS-final\\fa_human.csv", sep = ",", row.names = TRUE)
