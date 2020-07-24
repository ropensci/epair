# Functions created to experiment with EPA API.
# These functions are no longer in use. 

#' Perform call and convert data into list
#'
#' @param call URL following structure from EPA API
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' endpoint <- 'list/states'
#' call <- create.base.call( endpoint )
#' call.data <- perform.call( call )
#' call.data$Header
#' call.data$Data
perform.call <- function( call ){
  raw <- GET( call )
  data <- content( raw, "text" )
  converted <- fromJSON( data, flatten = TRUE)
  return( converted )
}

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

#' Take a list of html tables, output a list of lists, each list a service
#'
#' @param list.tables EPA API html tables
#'
#' @return A list containing services, each service is a list.
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' services <- populate.all.services( API.tables )
#' services$MetaData$Filter$`Known Issues`$Endpoint
populate.all.services <- function( list.tables ){
  services.list <- list()
  for( i in 1:length( list.tables ) ){
    df <- list.tables[[i]]
    if(  length( df$Filter ) != 0  ) { # Ensure all services going into final list have a filter
      if( !is.na( df$Filter )[1] ) {   # Ensure the filter isn't NA
        service.name <- df$Service[1]
        services.list[[ service.name ]] <- populate.service.list( df )
      }
    }
  }
  return( services.list )
}

#' Take a df - a table from EPA site - and output a list with easy accessing for variables
#'
#' @param df Data frame of an HTML table in the EPA API site.
#'
#' @return A list containing the service variables for a service in the EPA API site
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' df <- API.tables[[4]]
#' result <- populate.service.list( df )
#' result$Filter$`Known Issues`$RequiredVariables
populate.service.list <- function( df ){
  result.list <- list()
  result.list$Service <- df$Service[1]
  
  corrected.df <- correct.overflow.filter( df )
  result.list$Filter <- create.filter.list( corrected.df )
  
  return( result.list )
}

#' Give a service name
#'
#' @param df 
#' @param service.list 
#'
#' @return Service 
#'
#' @examples
assign.service.name <- function( df, service.list ){
  service.name <- df$Service[1]
  service.list[[service.name]] <- "Place Holder"
  return( service.list )
}
service.list <- assign.service.name( single, service.list)

#' Remove extraneous service name variable from all services
#'
#' @param services The EPA API services as a list
#'
#' @return List of services without service name variable
#' @export
#'
#' @examples
#' SERVICES <- remove.all.service.names( SERVICES )
#' SERVICES
remove.all.service.names <- function( services ){
  services <- lapply( services, remove.service.name )
}

#' Remove extraneaous service name variable in a service list
#'
#' @param services List of services from the EPA API
#'
#' @return A service list without the service name variable
#' @export
#'
#' @examples
#' services <- SERVICES
#' services[[1]] <- remove.service.name( services[[1]] )
#' services[[1]]
#' 
remove.service.name <- function( service ){
  service <- within( service, rm( Service ))
}

#' Create the filter list to allow for chained variable calls
#'
#' @param df Data frame containing the service. Assumes filters exist for this data frame.
#'
#' @return A list for filters in a service
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' df <- API.tables[[4]]
#' filter.list <- create.filter.list( df )
#' filter.list
create.filter.list <- function( df ){
  
  # Keep track of each filter entry
  counts <- table(df$Filter)
  names.count <- names(counts)
  
  filter.list <- list()
  for(i in 1:length( names.count  )){
    
    filter.name <- names.count[ i ]
    count <- counts[[ filter.name ]]
    row.numbers <- determine.filter( filter.name, df )
    
    results.list <- list()
    for( element in row.numbers){
      results.list <- append( results.list, create.list.endpoints.examples.params( element, df ) )
    }
    filter.list[[filter.name]] <- results.list
  }
  return( filter.list )
}

#' Find the indices for a filter in a data frame
#'
#' @param name.filter The name of the filter we want
#' @param df Data frame containing the filters
#'
#' @return Vector of integer indices showing where a particular filter is
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' df <- API.tables[[4]]
#' name.filter <- 'Is the API available for use?'
#' indices <- determine.filter( name.filter, df)
#' indices
determine.filter <- function( name.filter, df ){
  indices <- which(df$Filter == name.filter)
  return( indices )
}

#' Make a list containing endpoints, example, and parameters for a service
#'
#' @param row.number The row number in the data frame containing a service
#' @param df A data frame containing services
#'
#' @return A list structure to allow for chained variable calls
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' df <- API.tables[[4]]
#' row.number <- 2
#' result <- create.list.endpoints.examples.params( row.number, df)
#' result
create.list.endpoints.examples.params <- function( row.number, df ){
  test.list <- list()
  if( ! example.check( df$Endpoint[row.number]) ){
    test.list$Endpoint <- df$Endpoint[row.number]
  }
  if( ! example.check( df$'Required Variables'[row.number]) ){
    test.list$RequiredVariables <- df$'Required Variables'[row.number]
  }
  
  if( ! is.na( df$'Optional Variable'[ row.number ]) ){
    if( ! example.check( df$`Optional Variables`[row.number]) & df$'Optional Variables'[row.number] != ""){
      test.list$OptionalVariables <- df$`Optional Variables`[row.number]
    }
  }
  if( example.check( df$Endpoint[row.number]  ) ){
    test.list$Example <- df$Endpoint[row.number] # Should be an example
  }
  return( test.list )
}

#' Find out if a string has 'Example' in it
#'
#' @param string A string, intended as an entry in a dataframe containing info about services
#'
#' @return Boolean reflecting presence of 'Example' in string
#' @export
#'
#' @examples
#' example.check( "Example number one")
#' example.check( "Number two ")
example.check <- function( string ){
  return( grepl("Example", string, fixed = TRUE) )
}

#' Correct the overflow in filter names
#'
#' @param df A data frame containing overflow filter names.
#'
#' @return A data frame with overflow from service names corrected to be filter names
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' df <- API.tables[[5]] 
#' corrected.df <- correct.overflow.filter( df )
#' corrected.df
correct.overflow.filter <- function( df  ){
  copy.df <- df
  for( i in 1:length( df$Filter) ){
    if( df$Filter[i] == df$Service[1]){     # Assume that the service entry overflowed into the filter
      copy.df$Filter[i] <- df$Filter[i - 1] # Assign the previous entry, still in same filter
    }
  }
  return( copy.df )
}

#' Print the available variables
#'
#' @return 
#' @export
#'
#' @examples
#' show.variables()
show.variables <- function(){
  if( length(VARIABLES) == 0){
    stop( "Make sure VARIABLES has been populated with get.variables().")
  }
  print( colnames( VARIABLES ) )
}

#' Print SERVICE.NAMES to see names of services offered
#'
#' @return
#' @export
#'
#' @examples
#' show.service.names()
show.service.names <- function(){
  if( length(SERVICE.NAMES) == 0 ){
    stop( "Make sure SERVICE.NAMES has been populated.")
  }
  print( colnames( SERVICE.NAMES ) )
}
