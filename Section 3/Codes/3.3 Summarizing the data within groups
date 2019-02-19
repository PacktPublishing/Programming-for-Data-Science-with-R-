
library(hflights)
library(dplyr)


# Converting into local dataframe
flights <- tbl_df(hflights) 


#**********************************
#*****      SUMMARISE      ********
#**********************************

flights %>% # selecting the data 
    group_by(Dest) %>% #group by destination
    summarise(avg_delay = mean(ArrDelay, na.rm=TRUE)) # find the mean arr delay 

# Summarise all the variables:
##`summarise_all` allows you to apply the same summary function to all columns at once
##`summarise_at` allows you to apply the same summary function to selected columns at once
##`summarise_if` allows you to apply the same summary function to columns that follow certain condition at once


# Summarise_all 
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_all(  mean  , na.rm = T   )



# Summarise_at
# for each carrier, calculate the percentage of flights cancelled or diverted	
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_at(c("Cancelled" , "Diverted") ,
               funs(Mean = mean(. , na.rm = T) ,
                    Median = median(. , na.rm = T)))	   
			   
# for each carrier, calculate the minimum and maximum arrival and departure delays
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_at( vars(contains("Delay")) ,  funs(Mean= mean(. , na.rm = T) , 
               Median = median(. , na.rm=T)) )



# Summarise_if
#for all the integer variables find mean , min

flights %>%
  group_by(UniqueCarrier) %>%
  summarise_if( is.integer ,  funs(mean , min, max) )


#**********************************
#*****    SOME MORE USES   ********
#**********************************


# for each destination, show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table()

