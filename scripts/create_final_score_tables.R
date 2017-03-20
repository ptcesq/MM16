# Script to play with MM2016 data 
library(RSQLite)
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
dbListTables(conn)
df <- dbGetQuery(conn, "SELECT * from final2016")
source('~/r_projects/MM16/scripts/final_score.R')

for (i in 1985:2015){
  print(i)
  q_string <- paste0("SELECT * from TourneyCompactResults WHERE Season=", i)
  df <- dbGetQuery(conn, q_string)
  current_year <- get_final(df)
  table_name <- paste0('final', i)
  dbWriteTable(conn, table_name, current_year, overwrite=TRUE)
}



