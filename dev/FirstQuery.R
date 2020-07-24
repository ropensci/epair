in# Experiment with json queries in the api

library(jsonlite)
library(httr)

source("Utility.R")

# Setup authentication strings 
epa.authentication <- create.authentication( "glo003@bucknell.edu", "goldram72")
options( epa_authentication = epa.authentication)

## Show available services
get.services()
show.services()

## Call without variables
# Setup a call
endpoint <- 'list/states'
call <- create.base.call( endpoint )
call

# Perform the call, get dataframe of data in resulting call
call.data <- perform.call( call )
call.data

# Get raw results
raw.call <- perform.call.raw( call )
raw.call

## Call with variables
# Setup the call
endpoint <- 'dailyData/byState'
variable.list <- list( "state" = '37', 
                       "bdate" = '20200101', 
                       "edate" = '20200102', 
                       "param" = '44201')    # Make sure variables declared follow parameter names. 
                                             # Example: state must be 'state' not 'State' or 'STATE'
call <- create.base.call( endpoint )
call <- add.variables( call, variable.list )
call

# Perform the call, get dataframe of data in resulting call
call.result <- perform.call( call )
call.result

## Find which variables are available
get.variables()
show.variables()

## For a variable, see its codes
# -- A call without requiring additional variables
endpoint <- get.list.variable.endpoint( "state")
base.call <- create.base.call( endpoint )
call.results <- perform.call(base.call)
call.results

# -- A call requiring additional variables
state <- "01"
endpoint <- get.list.variable.endpoint( "county" )
base.call <- create.base.call( endpoint )
call <- add.variable( base.call, state)
call.results <- perform.call( call )
call.results
