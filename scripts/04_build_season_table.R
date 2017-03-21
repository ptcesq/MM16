
# get original data 
library(RSQLite)
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
df <- dbGetQuery(conn, 'SELECT * FROM RegularSeasonDetailedResults')

# create alternate data frame 
source('~/r_projects/MM16/scripts/final_score_season.R')
df2 <- get_final_season(df)
df2$season <- as.factor(df$Season)
df2$score <- df$Wscore/df$Lscore


# Save Table 
dbWriteTable(conn, "season_details", df2, overwrite=TRUE)
