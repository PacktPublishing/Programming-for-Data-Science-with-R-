


#***************************************
#***** Simple Linear Regression ********
#***************************************


x <- c(152, 176, 138, 186, 128, 136, 179, 163, 152, 131)
y <- c(64, 813, 56, 91, 47, 57, 76, 72, 62, 48)


linear_reg <- lm(y~x)

# Lets plot this now: 

plot(y,x,col = "blue",main = "Height & Weight Regression",
abline(lm(x~y)),cex = 1.3,pch = 16,xlab = "Weight in Kg",ylab = "Height in cm")



# Using the predict function to predict the unknown y using given y 

predict()

#***************************************
#***** Multiple Linear Regression ******
#***************************************


input <- mtcars[,c("mpg","disp","hp","wt")]
print(head(input))

input <- mtcars[,c("mpg","disp","hp","wt")]

# Create the relationship model.
model <- lm(mpg~disp+hp+wt, data = input)

# Show the model.
print(model)

# Get the Intercept and coefficients as vector elements.
cat("# # # # The Coefficient Values # # # ","\n")

a <- coef(model)[1]
print(a)

Xdisp <- coef(model)[2]
Xhp <- coef(model)[3]
Xwt <- coef(model)[4]



# Generating the regression line: 


x1 = 170
x2 = 100 
x3 = 3.1

a + Xdisp * x1 + Xhp * x2 + Xwt * x3


predict()

