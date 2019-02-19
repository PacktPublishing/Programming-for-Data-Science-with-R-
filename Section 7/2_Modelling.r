
# Installing the important packages: 

#install.packages("missForest")
#install.packages("caret")
#install.packages("caret")
#install.packages("e1071")

library(missForest)     # Imputing the missing values from dataset
library(caret)          # Using Caret package (for models)
library(randomForest)   # Dependeny for random forest regression
library(e1071)          # to support the other packages

# Importing the data: 

train <- read.csv("housing_data.csv")

#Store sales_price as another variable: 
SalePrice = train$SalePrice 
train$SalePrice = NULL


#***************************************
#****** Missing Value Imputation *******
#***************************************

missing <- sort(sapply(train ,function(x) sum(is.na(x))  ) , decreasing = T)
missing[missing>0]

?missForest # See the help to know more about the imputation:
imputed_data <- missForest(xmis = train, maxiter = 10, ntree = 100,mtry = floor(sqrt(ncol(train))))


train_no_missing <- imputed_data$ximp
head(train_no_missing)
dim(train_no_missing)

# Let's check the presence of missing value again: 

missing <- sort(sapply(train_no_missing ,function(x) sum(is.na(x))  ) , decreasing = T)
missing[missing>0]

# Create dummy variables: 
dummies <- dummyVars(~., data = train_no_missing)

train_no_missing_2 <- data.frame(predict(dummies, newdata = train_no_missing))
train_no_missing_3 <- cbind(train_no_missing_2, SalePrice)


#***************************************
#***********1. Linear Model  ***********
#***************************************


lm_model <- train(SalePrice~., data=train_no_missing_3, method="lm",metric="RMSE",
                  maximize=FALSE,trControl=trainControl(method = "repeatedcv",number = 10))


lm_model                  
### Verify accuracy
lm_model$results


#***************************************
#************ 3.Random Forest **********
#***************************************


rf_model <- train(SalePrice~., data=train_no_missing_3,method="rf",metric="RMSE",
                  maximize=FALSE,trControl=trainControl(method="repeatedcv",number=5),
                  tuneGrid=expand.grid(mtry = c(5)), importance = T, allowParallel = T, prox = T)

#  Verify accuracy
rf_model$results

#Take a look at contribution of each variable to make prediction
varImp(rf_model)



#**********************************************
#******** 3.Comparing the two models **********
#**********************************************

rf_model$results
lm_model$results

