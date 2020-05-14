# Experiment with json queries in the api

library(jsonlite)
library(httr)

source("Utility.R")

authentication <- create_authentication( 'glo003@bucknell.edu', 'goldram72'  )  
authentication

base_query <- create_base_query( 'list/states' )
base_query

call <- query( base_query, authentication  )
call

raw.result <- GET( call )
raw.result

result.data <- content( raw.result, "text"  )
result.data

final.data <- fromJSON( result.data, flatten = TRUE )
final.data


