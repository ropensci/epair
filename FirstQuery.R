# Experiment with json queries in the api

library(jsonlite)
library(httr)

source("Utility.R")


## Place the state name and get the state code would be nice nyeh?
## Overarching -> what codes should I use for a particular state?
## Overarching global variables for API keys

## Base requirements
authentication <- create_authentication( 'glo003@bucknell.edu', 'goldram72'  )  
endpoint <- 'dailyData/byState'
base_query <- create_base_query( endpoint )
base_query_auth <- paste( base_query, authentication, sep = "" )

## Declare variables
## Set up variables in a list

variable.list <- list( "state" = '37', 
                       "bdate" = '20200101', 
                       "edate" = '20200102', 
                       "param" = '44201')




call <- add.variables( base_query_auth, variable.list )
call.result <- perform.call( call )


