

library(missForest)
library(mice)


#**********************************
#*****    Missing Values   ********
#**********************************


# Load iris dataset:

data(iris)

# Introduce some missing values
iris.mis <- prodNA(iris, noNA = 0.1)

# Get the missing values in the entire dataset
sapply(iris.mis , function(x) sum(is.na(x)))


#or Check the missing values introduced using summary function:
summary(iris.mis)

# Removing categorical data
iris.mis <- subset(iris.mis, select = -c(Species))
summary(iris.mis)

# Using mice package for treating the missing values:
library(mice)

md.pattern(iris.mis)

# Imputing the missing values using mice:

imputed_Data <-
  mice(
    iris.mis,
    m = 5,
    maxit = 50,
    method = 'pmm',
    seed = 500
  )

# Now since there are 5 datasets that are imputed, you can select anyone:

completeData <- complete(imputed_Data, 2)
head(completeData)
#**********************************
#*****      Outliers       ********
#**********************************

# Here we will use the cars data:
# Inject outliers into data.
cars1 <- cars[1:30,]  # original data
cars_outliers <-
  data.frame(speed = c(19, 19, 20, 20, 20),
             dist = c(190, 186, 210, 220, 218))  # introduce outliers.
cars2 <- rbind(cars1, cars_outliers)  # data with outliers.


# Plot of data with outliers.
par(mfrow = c(1, 2))
plot(
  cars2$speed,
  cars2$dist,
  xlim = c(0, 28),
  ylim = c(0, 230),
  main = "               \n Presence of Outliers",
  xlab = "speed",
  ylab = "dist",
  pch = "*",
  col = "green",
  cex = 2
)
abline(
  lm(dist ~ speed, data = cars2),
  col = "black",
  lwd = 3,
  lty = 2
)

# Plot of original data without outliers. Note the change in slope (angle) of best fit line.
plot(
  cars1$speed,
  cars1$dist,
  xlim = c(0, 28),
  ylim = c(0, 230),
  main = "\n \nOutliers removed \n A better fit!",
  xlab = "speed",
  ylab = "dist",
  pch = "*",
  col = "green",
  cex = 2
)
abline(
  lm(dist ~ speed, data = cars1),
  col = "black",
  lwd = 3,
  lty = 2
)


#************ Treating the outliers ************


#Capping
x <- cars2$dist
qnt <- quantile(x, probs = c(.25, .75), na.rm = T)
caps <- quantile(x, probs = c(.05, .95), na.rm = T)
H <- 1.5 * IQR(x, na.rm = T)
x[x < (qnt[1] - H)] <- caps[1]
x[x > (qnt[2] + H)] <- caps[2]


