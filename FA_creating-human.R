# Heike Joana Wege
# 13.-15.12.2017

# Datawrangling-Script for the IODS-Final-Assignment 

# Choosing and loading the datasets "human development (hd)" and "gender inequality index (gii)":

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# taking a look at their structures and dimensions:

str(hd)
dim(hd)

str(gii)
dim(gii)

