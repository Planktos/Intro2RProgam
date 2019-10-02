# Summarizing data
# 2 Oct 2019
# ------

library(tidyverse)
install.packages("nutshell")
library(nutshell)

#data we will be using today ----
data("batting.2008")
d <- batting.2008

#tapply --- (tidyverse function)
## find sum of all home runs
hr <- tapply(X = d$HR, INDEX = list(d$teamID), FUN = sum)

## find quantile values for home runs by team
## fivenum gives you: min, lower-hinge, median, upper-hinge, and max value

hr.q <- tapply(X = d$HR, INDEX = list(d$teamID), FUN = fivenum)

# one category summarize
lg.q <- tapply(X = (d$H/d$AB), INDEX = list(d$lgID), FUN = fivenum)

# two category summarize
bats <- tapply(X = d$HR, INDEX = list(d$lgID, d$bats), FUN = mean)

# three category summarize (crazy array...ahhhh)
bats.team <- tapply(X = d$HR, INDEX = list(d$lgID, d$teamID, d$bats), FUN = mean)

#aggregate ----

team.stats.sum <- aggregate(x = d[,c("AB","H","BB","2B","HR")], by=list(d$teamID), FUN=sum)
team.stats.mean <- aggregate(x = d[,c("AB","H","BB","2B","HR")], by=list(d$teamID), FUN=mean)

# tidyverse summarise()----
team.sum = d %>% group_by(teamID) %>% summarise(ABsum = sum(AB), ABmean = mean(AB),
                                                ABsd = sd(AB), ABcount = n())

lg.team.sum = d %>% group_by(lgID, teamID) %>% summarise(ABsum = sum(AB), ABmean = mean(AB),
                                                ABsd = sd(AB), ABcount = n())


#rowsum ----
#when you just want to add up the values in each row

rs <- rowsum(d[,c("AB","H","HR","2B","3B")], group = d$teamID)

#counting variables ----
#use the function "tabulate"

HR.cnts <- tabulate(d$HR)
names(HR.cnts) <- 0:(length(HR.cnts) - 1)

#aside about the 'names' function --
m <- matrix(nrow = 4, ncol = 3)
colnames(m) <- c("one","two","three")
rownames(m) <- c("apple", "pear","orange","berry")

#table ---
table(d$bats)
table(d[,c("bats","throws")])

#reshaping your data ----
n <- matrix(1:10, nrow = 5)
t(n)

v <- 1:10
v
t(v)

#unstack and stack ----

s <- d[,c("lgID","teamID","AB","HR","throws")]
s.un <-  unstack(x = s, form = teamID ~ HR)
s.un <-  unstack(x = s, form = HR ~ AB)

#melt & cast ----
library(reshape2)

#use the "cast" function to change data frame from the long to wide format
s.wide <- dcast(data = s, value.var = "HR", formula = "lgID" ~ "teamID", fun.aggregate = mean)



