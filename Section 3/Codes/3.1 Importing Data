

#******************************************************
#*********     Preparing your R workspace      ********
#******************************************************

# You might want to clean the environment before you start: 
rm(list=ls()) 

#Getting the working directory: 
getwd()

#Setting the working directory: 
setwd("<location of your dataset>")



#******************************************************
#*********        DATA IMPORT METHODS          ********
#******************************************************

#install.packages("data.table") #(Install if not previously installed ) 

# Creating a dummy large dataset: ( Around 100 Mbs ) 

n = 2e6
DT = data.table( a=sample(1:1000,n,replace=TRUE),
                 b=sample(1:1000,n,replace=TRUE),
                 c=rnorm(n),
                 d=sample(c("foo","bar","baz","qux","quux"),n,replace=TRUE),
                 e=rnorm(n),
                 f=sample(1:1000,n,replace=TRUE) )
DT[2,b:=NA_integer_]
DT[4,c:=NA_real_]
DT[3,d:=NA_character_]
DT[5,d:=""]
DT[2,e:=+Inf]
DT[3,e:=-Inf]

# Storing the dataset on the local table 
write.table(DT,"test.csv",sep=",",row.names=FALSE,quote=FALSE)

#Check the size of the file 
cat("File size (MB):", round(file.info("test.csv")$size/1024^2),"\n")  # ~ 100 MBS


########### Lets Import the file created above ############


# Method 1 ( Common Method ) 
system.time(DF1 <-read.csv("test.csv",stringsAsFactors=FALSE))

# Method 2 (Suggested Method) 
system.time(DT <- fread("test.csv"))



########### Creating another large Dataset  ############

l = vector("list",10)
for (i in 1:10) l[[i]] = DT
DTbig = rbindlist(l)
tables()
write.table(DTbig,"testbig.csv",sep=",",row.names=FALSE,quote=FALSE)
cat("File size (MB):", round(file.info("testbig.csv")$size/1024^2),"\n")  # ~ 700 MBS



# Method 1 ( Common Method ) 
system.time(DF1 <-read.csv("testbig.csv",stringsAsFactors=FALSE))

# Method 2 (Suggested Method) 
system.time(DT <- fread("testbig.csv"))












