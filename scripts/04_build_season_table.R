
# get original data 
library(RSQLite)
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
df <- dbGetQuery(conn, 'SELECT * FROM RegularSeasonDetailedResults')

# create alternate data frame 
source('~/r_projects/MM16/scripts/final_score_season.R')
df2 <- get_final_season(df)         # Team combo 
df2$season <- as.factor(df$Season)  # Season 
df2$score <- df$Wscore/df$Lscore    # score ration w/l 
df2$ot <- df$Numot                  # OT periods
df2$loc <- as.factor(df$Wloc)       # location for winning team 
df2$fgm <- df$Wfgm/df$Lfgm          # feild goals made 
df2$fga <- df$Wfga/df$Lfga          # feild goals attempted 
df2$fgm3 <- df$Wfgm3/df$Lfgm3       # field goal made 3 point 
df2$fga3 <- df$Wfga3/df$Lfga3       # field goal attempted 3 point
df2$ftm <- df$Wftm/df$Lftm          # free throw made 
df2$fta <- df$Wfta/df$Lfta          # free throw attempted 
df2$or <- df$Wor/df$Lor             # Offensive rebound 
df2$dr <- df$Wdr/df$Ldr             # Defensive rebound 
df2$ast <- df$Wast/df$Last          # Assist 
df2$to <- df$Wto/df$Lto             # Turn Over 
df2$blk <- df$Wblk/df$Wblk          # Blocks 
df2$pf <- df$Wpf/df$Lpf             # Personal Fouls 

# Save Table 
dbWriteTable(conn, "season_details", df2, overwrite=TRUE)
