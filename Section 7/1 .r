
#install.packages("dplyr")
#install.packages("data.table")
#install.packages("ggplot2")
#install.packages("corrplot")
#install.packages("scales")

library(data.table)
library(dplyr)
library(ggplot2)
library(corrplot)



train <- read.csv("housing_data.csv")
head(train)



# Data  Checks: 

dim(train)
str(train)

# Check the NA's 
missing <- sort(sapply(train ,function(x) sum(is.na(x))  ) , decreasing = T)
missing[missing>0]

cat("There are" , length(missing[missing>0]) , "variables with missing values")




# Let us check the response variable : 

options( scipen =999)
# Plot of the sales: 
ggplot(data=train[!is.na(train$SalePrice),] ,  aes(x=SalePrice )) + 
  geom_histogram(fill="blue" ,binwidth = 10000) +
  xlim(c(0, 800000)) + 
  labs(x="Sale Price")
 

# Numerical verses the character variables : 

num_vars <- names(which(sapply(train , is.numeric)))
num_vars <-num_vars[-c(1,36,37)]   # Remove the id variable 


#Let us plot the correlation between these variables: 

all_numVar <- train[, num_vars] # Only take the numerical variables 

head(all_numVar)
str(all_numVar)

cor_numVar <- cor(all_numVar, use="pairwise.complete.obs") #correlations of train numeric variables

corrplot.mixed(cor_numVar , tl.col="black", tl.pos = "lt")


#sort on decreasing correlations with SalePrice
cor_sorted <- as.matrix(sort(cor_numVar[,'SalePrice'], decreasing = TRUE))
#select only high corelations
CorHigh <- names(which(apply(cor_sorted, 1, function(x) abs(x)>0.5)))
cor_numVar <- cor_numVar[CorHigh, CorHigh]

corrplot.mixed(cor_numVar , tl.col="black", tl.pos = "lt")


# Relationship between Sales Price and Overall Quality: 
attach(train)
ggplot( data = train , aes(x = as.factor(OverallQual) , y= SalePrice)) + 
  geom_boxplot() +   
  labs(x = "Quality" , y="Sales Price")


# Garage area and the sales price relationship 
names(train[, num_vars])
ggplot(train , aes(x =GrLivArea , y= SalePrice)) +  
  geom_point( ) + geom_smooth() +
  labs(x = "GrLivArea" , y="Sales Price")


ggplot(train , aes(x =GrLivArea , y= SalePrice , color= OverallQual)) +  
  geom_point( ) + theme_bw()  

detach(train)
  
  
# Treating missing values: 

round(missing[missing>0]/1460,2) # Proportion of missing variables: 
head(train$PoolArea)


##This should be done on individual basis. 


## Example: LotFrontage 

## A good method of imputation here could be imputing with median lot frontage
## per neighorhood.

ggplot( train , aes(x = as.factor(Neighborhood) , y=LotFrontage) ) +
  geom_bar(stat='summary' ,  fun.y = "median") + 
  theme(axis.text.x =  element_text(angle = 90)) + 
  scale_x_discrete(name="Neighorhood")
  
