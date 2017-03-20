# Script to play with MM2016 data 
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
dbListTables(conn)
