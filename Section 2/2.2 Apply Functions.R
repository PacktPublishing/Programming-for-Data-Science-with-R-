

set.seed(1)

# Construct a 5x6 matrix
df <- matrix(rnorm(20), nrow = 5, ncol = 4)

# Sum the values of each column with `apply()`
apply(df, 2, sum)


# Lapply:
# Create a list of matrices

A <- matrix(rnorm(25) , nrow = 5 , ncol = 5)
B <- matrix(runif(25) , nrow = 5 , ncol = 5)
C <- matrix(rnorm(25  , mean = 80 , sd = 20) , nrow = 5 , ncol = 5)


My_List <- list(A, B, C)

# Extract the 2nd column from `MyList` with the selection operator `[` with `lapply()`
# Lets extract the 2nd column from the above list
## Use "[" with lapply

`[`(A , 1 ,)

lapply(My_List, "[", , 2)



# Extract the 1st row from `My_List`
lapply(My_List, "[", 1,)

# Extract the 1st element of every matrix in the My_List
K = lapply(My_List , "[" , 1, 1))


#**********************************
#********* Some Use Cases  ********
#**********************************

x = matrix(sample(c(1:10,-999), 36, rep = TRUE), nrow = 6)
df <- data.frame(x)
names(df) <- letters[1:6]
df


##1.  Fixing the missing values ( replace -999 with NA in all columns, one by one)



fix_missing <- function(x) {
  x[x == -999] <- NA
  x
}


df[1:6] <- lapply(df[1:6], fix_missing)

#----------------------------------------------------------
##2. Finding the summary for all columns:

df <- data.frame(matrix(rnorm(20), nrow = 5, ncol = 4))

summary <- function(x) {
  c(mean= mean(x ), 
    median= median(x), 
    sd= sd(x), 
    mad = mad(x), 
    IQR=  IQR(x))
}

xyz = lapply(df, summary)
xyz$X1


### Removing NA's

summary <- function(x) {
  c(
    mean(x, na.rm = TRUE),
    median(x, na.rm = TRUE),
    sd(x, na.rm = TRUE),
    mad(x, na.rm = TRUE),
    IQR(x, na.rm = TRUE)
  )
}

lapply(df  , summary)

#sapply 
sapply(df  , summary)



# Optional
  
  summary_2 <- function(x) {
    funs <- c(mean, median, sd, mad, IQR)
    lapply(funs, function(f)
      f(x, na.rm = TRUE))
  }

lapply(mtcars , summary_2)
sapply(mtcars , summary_2)
