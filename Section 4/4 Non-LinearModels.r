


#simulate some data
set.seed(1)
x<-seq(0,100,1)
y<-((runif(1,10,20)*x)/(runif(1,0,10)+x))+rnorm(51,0,1)


#***** Simple Linear Regression ********

l_model <- lm( y ~ x )
l_pred <- predict(l_model) 

#get some estimation of goodness of fit
cor(y , l_pred)


#***** Non - Linear Regression ******** 
## Using nls function 

nonlin_model <-nls(y~a*x/(b+x))

#get some estimation of goodness of fit
cor(y,predict(nonlin_model))
### Non-Linear is a better fit: 


# Lets plot it: 
plot(x,y)
lines(x,predict(nonlin_model),lty=2,col="red",lwd=3)
lines(x,predict(l_model) , lty=2, col="blue" , lwd=2)



