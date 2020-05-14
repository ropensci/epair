# Get html data for API how to site https://aqs.epa.gov/aqsweb/documents/data_api.html

library(rvest)

source("Utility.R")

# Get table showing list of services
url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
df <- get.table( url, table.path )
class(df)
head(df, 1)
df <- remove.escapes( df )
df


