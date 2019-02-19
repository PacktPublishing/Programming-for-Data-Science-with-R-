

#Installing the package 
#install.packages("ggplot2")
library(ggplot2)

# We will be using the diamonds dataset (which is part of ggplot2 package) 

#Let us look at the dataset:
head(diamonds) 



#***************************************
#********* Grammer of Graphics *********
#***************************************

#The syntax for the ggplot: 

#Step 1: Specify the data: 

ggplot(diamonds) #At this point we have the empty plot: 

#Step 2:Add the geometries  

#ggplot(diamonds ) + 
#  geom_point()  
  
  
#Step 3:Add the aesthetics to the geometries:

ggplot(diamonds ) + 
  geom_point(aes(x= carat , y= price , color=cut , alpha=.25) ) 
  
## Alpha- for transparency 
  
  
  
#***************************************
#***** Geometries and Aesthetics  ******
#***************************************
  
# Simple Scatter Plot: 


p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point()

# Add aesthetic mappings
p + geom_point(aes(colour = factor(cyl)))
p + geom_point(aes(shape = factor(cyl) , colour = factor(cyl) ))
# A "bubblechart":
p + geom_point(aes(size = wt))



# Histograms: 

ggplot(diamonds, aes(x=carat)) +
  geom_histogram()

#1. binwidth
ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 1)

# no. of the bins:
ggplot(diamonds, aes(carat)) +
  geom_histogram(bins = 200)

# Yet another histogram: 
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)

# Frequency Plot 
ggplot(diamonds, aes(price, colour = cut)) +
  geom_freqpoly(binwidth = 500)
  
  
###########   For categorical Data ###########

# geom_bar is designed to make it easy to create bar charts that show
# counts (or sums of weights)
g <- ggplot(mpg, aes(x=class))
g + geom_bar()

# Number of cars in each class:
g + geom_bar(aes(fill = drv))

?geom_bar # See help for more aesthetics


# Flipping the bars: 
g + geom_bar(aes(fill = drv)) + coord_flip() 
?geom_bar



# Box Plot: 

p <- ggplot(mpg, aes(class, hwy))
p + geom_boxplot()
p + geom_boxplot(fill = "white", colour = "#3366FF")




  
#**********************************************
#****** Beautiying your visualizations ********
#**********************************************


g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)
# midwest <- read.csv("http://goo.gl/G1K41K")  # backup data source


#Adjusting the X and Y axis limits

g1 <- g + xlim(c(0, 0.1)) + ylim(c(0, 1000000)) 


#How to Change the Title and Axis Labels

gg <- g1 + labs(title="Area Vs Population", 
          subtitle="From midwest dataset", 
          y="Population", x="Area", 
          caption="Midwest Demographics")


#Color and Size of Points:
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(color="brown" , size=3) + geom_smooth(method="lm") 


#Sellecting the themes 
# Adding theme Layer itself.
gg + theme_bw() + labs(subtitle="BW Theme")
gg + theme_classic() + labs(subtitle="Classic Theme")

library(ggthemes)
gg + theme_economist()+scale_colour_economist() # from the ggthemes packages:



#**********************************************
#**********   A short case study! ************* 
#**********************************************




install.packages("ggalt")
library(ggalt)
options(scipen=999)  # turning off the scientific notation

data("midwest")

theme_set(theme_bw()) 

# Scatterplot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess" , se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 300000)) + 
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot", 
       caption = "Data Source: midwest") + 
  geom_encircle(data=midwest_select, 
                color="red", 
                size=1, 
                expand=0.08) 



#Let's encircle some points: 

install.packages("ggalt")
library(ggalt)

midwest_select <- midwest[midwest$poptotal > 270000 & 
                            midwest$poptotal <= 300000 & 
                            midwest$area > 0.025 & 
                            midwest$area < 0.05, ]


ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) +   # draw points
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) +   # draw smoothing line
  geom_encircle(aes(x=area, y=poptotal), 
                data=midwest_select, 
                color="red", 
                size=2, 
                expand=0.08) +   # encircle
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot + Encircle", 
       caption="Source: midwest")
	   
	   
# Congratulations! You have now learned to create great visualizations!