
# get original data 
library(RSQLite)
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
df <- dbGetQuery(conn, 'SELECT * FROM season_details')


df[mapply(is.infinite, df)] <- 1
df[mapply(is.na, df)] <- 0

# Save Table 
dbWriteTable(conn, "season_details", df, overwrite=TRUE)
