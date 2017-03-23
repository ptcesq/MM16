
# get original data 
library(RSQLite)
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
df <- dbGetQuery(conn, 'SELECT * FROM season_details')
cor(df)
