## Utility package for creating queries in EPA API 
# at https://aqs.epa.gov/aqsweb/documents/data_api.html#signup

# Globals
EMAIL <- ''
KEY <-  ''
AUTHENTICATION <- ''
SERVICES <- ''
VARIABLES <- ''
VARIABLE.TYPES <- list("state" = 'list/states',
                       "county" = 'list/countiesByState',
                       "site" = 'list/sitesByCounty',
                       "cbsa" = 'list/cbsa',
                       "classes" = 'list/parametersByClass',
                       "pqao" = 'list/pqaos',
                       "ma" = 'list/mas')

# Reset the global email
set.email <- function( email ){
  EMAIL <<- email
}

# Reset the global api key
set.key <- function( key ){
  KEY <<- key
}

create.authentication <- function(){
  authentication.string <- sprintf('&email=%s&key=%s', EMAIL, KEY)
  AUTHENTICATION <<- authentication.string
}

create.base.call <- function( endpoint ){
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

# Output a data frame containing a table using url and xpath to the table 
get.table <- function( url, table.xpath ){
  found.table <- url %>%
    read_html() %>%
    html_nodes( xpath = table.xpath ) %>% 
    html_table()
  return( found.table[[1]] )
}

# Remove \r \n \t and excess space from entries
# TODO, simplify code with multiple pattern regex matching
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

# Get the transpose of a df, and turn the first column into the names of the 
# df
get.transpose <- function( df  ){
  t.df <-  t(df)
  t.names <- c()
  for( i in 1:nrow(df)){
    t.names <- c(t.names, df[i, 1])
  }
  colnames(t.df) <- t.names
  return( as.data.frame(t.df, stringsAsFactors = FALSE) )
}

# Get table showing list of services
get.services <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table( url, table.path )
  
  # TODO extra spaces, some words got squished
  df <- remove.escapes( df )
  
  t.df <- get.transpose(df)
  
  SERVICES <<- t.df
  return( new.df )
}
# Print services provided by the API and get df containing services and descriptions.
## TODO speed up response by setting a constant value
## TODO setup assert to ensure services are present
show.services <- function(){
  print( colnames( SERVICES ) )
}

# Get table showing list of services
get.variables <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[2]'
  df <- get.table( url, table.path )
  
  # TODO extra spaces, some words got squished
  df <- remove.escapes( df )
  
  t.df <- get.transpose(df)
  
  VARIABLES <<- t.df
  return( t.df )
}

# Print the available variables. 
# TODO assert those variables
show.variables <- function(){
  print( colnames( VARIABLES ) )
}

# Check if the service is up and running 
is.service.running <- function(){
  endpoint <-  'metaData/isAvailable'
  url <- create_base_query( endpoint  )
  result <- GET( url )
  return(result)
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

## Alternate function to create based on variable name 
## General function to rule them all variable calls
add.variable <- function( query, variable, name = deparse( substitute( variable ) ) ){
  result <- paste( query, '&', name, '=', variable, sep = "" )
  return( result )
}

## Add all variables to a base query (includes authentication already)
add.variables <- function( query, variables ){
  var.names <- names( variables )
  for( i in 1:length( variables ) ){
    var.name <- var.names[i]
    query <- paste( query, '&', var.name, '=', variables[[ var.name ]], sep = "" )
  }
  return( query )
}

# Perform the call and convert data into data frame
perform.call <- function( call ){
  raw <- GET( call )
  data <- content( raw, "text" )
  converted <- fromJSON( data, flatten = TRUE)
  return( converted )
}

# Perform the call and maintain jsonlite structure
perform.call.raw <- function( call ){
  raw <- GET( call )
  return( raw )
}

get.list.variable.endpoint <- function( variable.type ){
  name <- substitute( variable.type ) 
  return( VARIABLE.TYPES[[name]])
}


