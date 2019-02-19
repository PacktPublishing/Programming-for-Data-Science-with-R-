

library(hflights)
library(data.table)

DT <- data.table(hflights)
DT

# i 
DT[ Month==1 & DayofMonth==1  ,    ,  ]

# j
DT[  , list (Mean = mean(DepDelay , na.rm=T) , Min= min(DepDelay , na.rm=T))  ,]


# by 

DT[  , list (Mean = mean(DepDelay , na.rm=T) , Min= min(DepDelay , na.rm=T))  , 
     by=c("Month" , "Year")]


