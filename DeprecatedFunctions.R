# Functions created to experiment with EPA API.
# These functions are no longer in use. 

#' Populate SERVICES, VARIABLES, and ENDPOINTS to be ready for the user to query
#' TODO modify for system without global variables
#' @return
#' @export
#'
#' @examples
#' setup.services.variables.endpoints()
#' SERVICES
#' VARIABLE
#' ENDPOINTS
setup.services.variables.endpoints <- function(){
  
  get.service.names()
  get.services()
  SERVICES <<- list.remove.escapes.spaces( SERVICES )
  SERVICES <<- remove.all.service.names( SERVICES )
  
  get.variables()
  
  get.endpoints()
}

#' Email for API in queries
#'
#' @param email Email used to sign up with the EPA API. 
#' Sign your email up at https://aqs.epa.gov/aqsweb/documents/data_api.html#signup. 
#'
#' @return
#' @export
#'
#' @examples
#' set.email( "myemail@domain.com" )
#' EMAIL 
set.email <- function( email ){
  EMAIL <<- email
}

#' Key for API in queries
#'
#' @param key Key for making data request to EPA API.
#' Get your key at https://aqs.epa.gov/aqsweb/documents/data_api.html#signup.
#'
#' @return
#' @export
#'
#' @examples
#' set.key( "mykey" )
#' KEY
set.key <- function( key ){
  KEY <<- key
}

#' Make the first call when forming a query.  
#'
#' @param endpoint Endpoint for forming a query. See ENDPOINTS for all available endpoints. See 
#' SERVICES if you know the service but not the endpoint.
#'
#' @return A URL string containing authentication for the call.
#' @export
#'
#' @examples
#' endpoint <- "list/states"
#' call <- create.base.call( endpoint )
#' call
#create.base.call <- function( endpoint ){
if( AUTHENTICATION == ''){
  stop( "Make sure AUTHENTICATION has been setup properly.")
}
base = 'https://aqs.epa.gov/data/api/'
result <- paste( base, endpoint, "?", AUTHENTICATION, sep = "")
return( result )
}

create_base_query <- function( endpoint ){
  # Assuming base doesn't change for a near future. 
  base = 'https://aqs.epa.gov/data/api/'
  query = paste( base, endpoint, "?", sep = '' )
  return(query)
}

# Consider modifying to iterate over variables someone might call
query <- function( base_query, authentication  ){
  call <- paste( base_query, authentication, sep = '' )
  return( call )
}

# Append a state variable fips code to a query
add.state <- function( query, state.code ){
  result = paste( query, '&state=', state.code, sep = "")
  return(result)
}

# Take a query, add the beginning date
add.bdate <- function( query, bdate ){
  result <- paste( query,'&bdate=', bdate, sep = "" )
  return( result )
}

# Take a query add the ending date
add.edate <- function( query, edate ){
  result <- paste( query, '&edate=', edate, sep = "" )
  return( result )
}

# Add a parameter to a query
add.param <- function( query, param ){
  result <- paste( query, '&param=', param, sep = "" )
  return( result )
}

remove.escapes.spaces <- function( df ){
  for(i in 1:nrow(df) ){
    for(j in 1:ncol(df) ){
      df[i, j] <- gsub( "\r\n", "", df[i, j] )
      df[i, j] <- gsub( "\t", "", df[i, j] )
      df[i, j] <- gsub( "   ", "", df[i, j] )
    }
  }
  return( df )
}
