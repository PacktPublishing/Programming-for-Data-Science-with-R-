

# Loading the dataset 

# Load the Breast Cancer data from mlbench library: 
# install.packages("mlbench")
data(BreastCancer, package="mlbench")
bc <- BreastCancer[complete.cases(BreastCancer), ]  # create copy with no na's


# Check the structure of the data 
str(bc)


#***************************************
#********* Logistic Regression *********
#***************************************


# Template code
## Step 1: Build Logit Model on Training Dataset
logitMod <- glm(Y ~ X1 + X2, family="binomial", data = trainingData) #do not run

## Step 2: Predict Y on Test Dataset
predictedY <- predict(logitMod, testData, type="response") #do not run


# Run the logistic model with one variable:
glm(Class ~ Cell.shape, family="binomial", data = bc)

## In the above model, the Cell thickness is taken as a factor variabl (Why it may be an issue?) 



# Convert factors to numeric
for(i in 2:10) {
 bc[, i] <- as.numeric(as.character(bc[, i]))
}

# Convert the class into '0' and '1'
bc$Class <- ifelse(bc$Class == "malignant", 1, 0)
bc$Class <- factor(bc$Class, levels = c(0, 1))


# Run the logistic model on three variables: 

logitmod <- glm(Class ~ Cl.thickness + Cell.size + Cell.shape, family = "binomial", data=bc)

summary(logitmod)


#***************************************
#************* Decision Trees **********
#***************************************

# Load the party package. 
# install.packages("party")
library(party)

# Get the data 
data(BreastCancer, package="mlbench")
bc <- BreastCancer[complete.cases(BreastCancer), ]  # create copy with no na's


# Convert factors to numeric
for(i in 2:10) {
  bc[, i] <- as.numeric(as.character(bc[, i]))
}


## Let's create two sets of data- 
##i. Train ( to build the model)  & 
##ii. Test to predict the model on new data: 
index <- round(sample(nrow(bc) , 0.7*nrow(bc)))
bc_train <- bc[index,]
bc_test <- bc[-index,]




# Give the chart file a name.
png(file = "decision_tree.png")

# Create the tree.
output.tree <- ctree(
  Class ~ Cl.thickness , 
  data = bc_train)

summary(output.tree)



# Plot the tree.
plot(output.tree)



#************* Random Forest **********
# install.packages("randomForest")
library(randomForest)

# Create the forest.
output.forest <- randomForest(Class ~ Cl.thickness + Cell.size , 
                              data = bc_train)

# View the forest results.
print(output.forest) 

table(bc$Class)
# Importance of each predictor.
print(importance(output.forest))

#Predicting on the test data
predict(output.forest , bc_test)


#***************************************
#******* Support Vector Machines *******
#***************************************

#Import Library
#install.packages("e1071")
library(e1071) #Contains the SVM 

# there are various options associated with SVM training; like changing kernel, gamma and C value.

# create model
svm_model <- svm(Class ~ Cl.thickness + Cell.size + Cell.shape , data=bc_train ,kernel='linear',gamma=0.2,cost=100)

#Predict Output
preds <- predict(svm_model,bc_test)
table(preds)

#Compare predictions with the actuals: 
preds_1 <- cbind(data.frame(preds) , bc_test$Class)
table(bc_test$Class) # Actuals 
table(preds_1) # Actuals vs predicted 

# 79 out of 82 malignant cases have been correctly predicted by the model!




#***************************************
#******* Support Vector Machines *******
#***************************************




# We shall be using the College dataset:
library(ISLR)
library(neuralnet)
print(head(College,2))

# Lets normalize the data:
# Create Vector of Column Max and Min Values
maxs <- apply(College[,2:18], 2, max)
mins <- apply(College[,2:18], 2, min)


# Use scale() and convert the resulting matrix to a data frame
scaled.data <- as.data.frame(scale(College[,2:18],center = mins, scale = maxs - mins))


# creating training and test set:
index <- round(sample(nrow(scaled.data) , 0.7*nrow(scaled.data)))
trainNN = scaled.data[index , ]
testNN = scaled.data[-index , ]


# Check out results
print(head(scaled.data,2))

# fit neural network
nn <- neuralnet(
  Grad.Rate ~ Enroll + Apps + Accept + Top10perc,
  data=trainNN, hidden=2, threshold=0.01)

#See the list of outputs in the neural network model: 
names(nn)

# plot neural network
plot(nn)


## Prediction using neural network

predict_testNN = compute(nn, testNN[,c("Enroll" , "Apps"  ,"Accept" ,"Top10perc")])
predict_testNN = (predict_testNN$net.result * (max(College$Grad.Rate) - min(College$Grad.Rate))) + min(College$Grad.Rate)



