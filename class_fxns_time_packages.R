#install package(data.table)
install.packages("data.table")

#Functions ----
#1) create a list of packages to install
packs <- c("tidyverse","stringr","plyr","reshape2","grid", "gridExtra", "pastecs","lubridate")

#write a function to install packages
n = length(packs)

for(i in 1:n){
  install.packages(packs[n])
}




#TIME OBJECTS ----

# setup R to keep decimal seconds in the times ----
options("digits.secs"=3)

# read-in data from a text file ----
file <- list.files(full.names = TRUE, pattern = "ISIIS")

file <- as.character(file)

d <- read.table(file, sep="\t", skip=10, header=TRUE, fileEncoding="ISO-8859-1",
                stringsAsFactors=FALSE, quote="\"", check.names=FALSE,
                encoding="UTF-8", na.strings="9999.99")

# create a proper date + time format
date <- scan(file, what="character", skip=1, nlines=1, quiet=TRUE)
date <- date[2]
mm <- str_sub(date,1,2)
dd <- str_sub(date,4,5)
dd <- as.numeric(dd)
yy <- str_sub(date,7,8)
dateNextDay <- str_c(mm,as.character(dd+1),yy, sep="/")

d$hour <- as.numeric(str_sub(d$time,1,2))
d$date <- date
d$dateTime <- str_c(d$date, d$time, sep=" ")
d$dateTime <- as.POSIXct(strptime(d$dateTime, format="%m/%d/%y %H:%M:%OS", tz="America/New_York"))

d$dateTime <- d$dateTime - time.zone.change * 3600



db$dateTime <- as.POSIXct(str_sub(db$image, 1, 14), format="%Y%m%d%H%M%OS", tz="America/New_York") + as.numeric(str_sub(db$image, 16, 18))/1000




#load libraries
library('data.table')

#load 'deck' data
#1) Go to the github repository link where you have the CSV file
# https://gist.github.com/garrettgman/9629323#file-deck-csv

# 2) Click on the raw option present on the top right of the data
#
# 3) This will open a new window in the browser.

deck <- fread("https://gist.githubusercontent.com/garrettgman/9629323/raw/ee5dfc039fd581cb467cc69c226ea2524913c3d8/deck.csv")
