# this script summarizes massey ranking. 

t1102 <- subset(massey2013to2015, team==1102)
## reshape2 still does its thing:
library(reshape2)
melted <- melt(t1102, id.vars=c("season", "orank"))

## This part is new:
library(dplyr)
grouped <- group_by(melted, season)
summarise(grouped, mean=mean(orank), sd=sd(orank))
