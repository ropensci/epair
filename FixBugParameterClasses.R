# Debug get services here
library(rvest)
library(httr)
library(jsonlite)

# Old version of function
services <- get.services()

# Problem point
services$List$Filter

# Setup to debug one table

# 1. Find table with listing info 

tbls <- get.all.tables()
tbls[5]
# --> It looks like the issue is with the table, not with how I populated
# --> services. The table comes in lacking the correct entry for classes. 

# --> Hard coding a solution. 
services <- get.services()

#' Update name to parameter class entry
#'
#' @param services List of services offered by the API.
#'
#' @return Services with corrected name of filter for parameter classes. 
#'
#' @examples
#' services <- get.services()
#' services <- change.classes.filter( services )
#' services$List$Filter$`Parameter Classes (groups of parameters, like criteria or all)`
change.classes.filter <- function( services ){
  names(services$List$Filter)[3] <- "Parameter Classes (groups of parameters, like criteria or all)"
  
  service.attributes <- list( Endpoint = "list/classes",
                              RequiredVariables = "email, key",
                              OptionalVariables = "",
                              Example = "https://aqs.epa.gov/data/api/list/classes?email=test@aqs.api&key=test")
  services$List$Filter$`Parameter Classes (groups of parameters, like criteria or all)` <- service.attributes
  return( services )
}



names(services$List$Filter)[3] <- "Parameter Classes (groups of parameters, like criteria or all)"

service.attributes <- list( Endpoint = "list/classes",
                            RequiredVariables = "email, key",
                            OptionalVariables = "",
                            Example = "https://aqs.epa.gov/data/api/list/classes?email=test@aqs.api&key=test")
services$List$Filter$`Parameter Classes (groups of parameters, like criteria or all)` <- service.attributes

services$List$Filter$`Parameter Classes (groups of parameters, like criteria or all)`

## Deemed unnecessary follow ups
# 1.5 Give a breakpoint
# --> In populat service list, possibly in the correction of the filter

# 2. Track it as the table goes through the function 

