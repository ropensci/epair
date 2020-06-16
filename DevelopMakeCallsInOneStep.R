# Develop a one step process for performing a call
# - Remember to include one for performing call raw

#' Place the URL as a call to the EPA API
#'
#' @param url A string with a valid URL for the EPA API
#'
#' @return Result of query from the API
#' @export
#'
#' @examples
place.call <- function( url ){
  raw <- GET( url )
  data <- content( raw, "text" )
  converted <- fromJSON( data, flatten = TRUE)
  return( converted )
}

#' Perform call and convert data into list
#'
#' @param call URL following structure from EPA API
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
perform.call <- function( endpoint, variables = list(), name = deparse( substitute( variables ) )  ){
  
  # The user passed no variables 
  if( length(variables) == 0){
    call <- create.base.call( endpoint )
    result <- place.call( call )
    return( result )
  }
  
  # The user passed a single variable
  if( class(variables) == "character"){
    call <- create.base.call( endpoint )
    call <- add.variable( call, variables, name )
    result <- place.call( call )
    return( result )
  }
  
  # The user passed multiple variables as a list
  call <- create.base.call( endpoint )
  call <- add.variables( call, variables )
  result <- place.call( call )
  return( result )
}

# First test - no variable
endpoint <- 'list/states'
result <- perform.call( endpoint )

# Second test - single variable
endpoint <- "list/countiesByState"
state <- "37"   # NC
result <- perform.call( endpoint, state )

# Third test - list of variables
endpoint <- 'dailyData/byState'
variable.list <- list( "state" = '37', 
                       "bdate" = '20200101', 
                       "edate" = '20200102', 
                       "param" = '44201')    
# Make sure variables declared follow parameter names. 
# Example: state must be 'state' not 'State' or 'STATE'
result <- perform.call( endpoint, variable.list )
