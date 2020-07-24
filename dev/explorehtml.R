# Get html data for API how to site https://aqs.epa.gov/aqsweb/documents/data_api.html
library(rvest)
source("Utility.R")

url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
table.xpath <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
get.table <- function( url, table.xpath ){
  found.table <- url %>%
    read_html() %>%
    html_nodes( xpath = table.xpath ) %>% 
    html_table()
  return( found.table[[1]] )
}


found.table <- url %>%
  read_html() %>%
  html_nodes( xpath = table.xpath) %>%
  html_attrs()
  
found.table

xpath = '//*[@id="main-content"]/div[2]/div[1]/div/div/table[5]'
codes <- get.table( url, xpath )
codes
