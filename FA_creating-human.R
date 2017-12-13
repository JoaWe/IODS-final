# Heike Joana Wege
# 13.-15.12.2017

# Datawrangling-Script for the IODS-Final-Assignment 

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
