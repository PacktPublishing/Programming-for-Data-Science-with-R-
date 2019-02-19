#Install the packages: 
# install.packages("hflights")
# install.packages("dplyr")
library(hflights)
library(dplyr)

data(hflights)
View(head(hflights))


# convert to local data frame
flights <- tbl_df(hflights)
flights
View(head(flights))
data.frame(head(flights))



#**********************************
#*********     FILTER      ********
#**********************************


# base R approach to view all flights on January 1
flights[flights$Month==1 & flights$DayofMonth==1, ]

#Use the dplyr package: 
filter(flights, Month==1 & DayofMonth==1)

# use pipe for OR condition
filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")


#**********************************
#*********     SELECT      ********
#**********************************

# Old Approach
flights[, c("DepTime", "ArrTime", "FlightNum")]

# dplyr approach
select(flights, DepTime, ArrTime, FlightNum)

colnames(flights)

# A lot more can be done using dplyr
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))

 #note: `starts_with`, `ends_with`, and `matches` (for regular expressions) can
 #also be used to match columns by name


 #**********************************
 #*****CHAINING & PIPELINING********
 #**********************************


# Use chaining to do multiple things in one go:
 flights %>% # 1. take the data 
     select(UniqueCarrier, DepDelay) %>% #2. select the columns 
     filter(DepDelay > 60) #3. filter the rows

#**********************************
#*****      SOME USES      ********
#**********************************


## Arranging:
flights %>%
    select(UniqueCarrier, DepDelay) %>%
    arrange(DepDelay)

# use `desc` for descending
flights %>%
    select(UniqueCarrier, DepDelay) %>%
    arrange(desc(DepDelay))


#**********************************
#***  MUTATE-Create new vars  *****
#**********************************

flights %>% mutate(Speed = Distance/AirTime*60  )

# store the new variable
flights <- flights %>% mutate(Speed = Distance/AirTime*60)
View(head(flights))


#*****************************************************
#***************      SUMMARISE      *****************
#***( We shall be looking at this in section 3) ******
#*****************************************************

flights %>% # selecting the data 
    group_by(Dest) %>% #group by destination
    summarise(avg_delay = mean(ArrDelay, na.rm=TRUE)) # find the mean arr delay 

# Summarise all the variables:
##`summarise_each` allows you to apply the same summary function to multiple columns at once


# for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(  funs(  mean , min(. , na.rm=T) , max(. , na.rm=T )    ), Cancelled, Diverted   )

# for each carrier, calculate the minimum and maximum arrival and departure delays
colnames(flights)

flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), matches("Delay"))

#**********************************
#*****    SOME MORE USES   ********
#**********************************


# for each destination, show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table()


#**********************************
#*****   WINDOW FUNCTIONS  ********
#**********************************


flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 10) %>%
  arrange(UniqueCarrier, desc(DepDelay))  


flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%
  arrange(UniqueCarrier, (DepDelay))
