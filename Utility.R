## Utility package for creating queries in EPA API 
## at https://aqs.epa.gov/aqsweb/documents/data_api.html#signup


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


####
#### Authentication 
####

set.email <- function( email ){
  EMAIL <<- email
}

set.key <- function( key ){
  KEY <<- key
}

create.authentication <- function(){
  authentication.string <- sprintf('&email=%s&key=%s', EMAIL, KEY)
  AUTHENTICATION <<- authentication.string
}

####
####
####

####
#### Calls 
####

create.base.call <- function( endpoint ){
  base = 'https://aqs.epa.gov/data/api/'
  result <- paste( base, endpoint, "?", AUTHENTICATION, sep = "")
  return( result )
}

####
#### Site scraping and data transformation
####

get.table <- function( url, table.xpath ){
  found.table <- url %>%
    read_html() %>%
    html_nodes( xpath = table.xpath ) %>% 
    html_table()
  return( found.table[[1]] )
}

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

get.transpose <- function( df  ){
  t.df <-  t(df)
  t.names <- c()
  for( i in 1:nrow( df ) ){
    t.names <- c( t.names, df[i, 1] )
  }
  colnames( t.df ) <- t.names
  return( as.data.frame(t.df, stringsAsFactors = FALSE) )
}

####
####
####

####
#### API functions
####

# Services the API provides
get.services <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table( url, table.path )
  
  df <- remove.escapes.spaces( df )
  
  t.df <- get.transpose(df)
  
  SERVICES <<- t.df
  return( t.df )
}

## TODO setup assert to ensure services are present
show.services <- function(){
  print( colnames( SERVICES ) )
}

# Variables for making requests
get.variables <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[2]'
  df <- get.table( url, table.path )
  
  # TODO extra spaces, some words got squished
  df <- remove.escapes.spaces( df )
  
  t.df <- get.transpose( df )
  
  VARIABLES <<- t.df
  return( t.df )
}

# Print the available variables. 
# TODO assert variables present
show.variables <- function(){
  print( colnames( VARIABLES ) )
}

# Check if the API is up and running 
is.API.running <- function(){
  endpoint <-  'metaData/isAvailable'
  url <- create.base.call( endpoint  )
  result <- GET( url )
  return( result )
}

## Add a vriable to a call, make sure the variable name matches API specs
add.variable <- function( query, variable, name = deparse( substitute( variable ) ) ){
  result <- paste( query, '&', name, '=', variable, sep = "" )
  return( result )
}

## Add all variables to a query - query should include authentication
add.variables <- function( query, variables ){
  var.names <- names( variables )
  for( i in 1:length( variables ) ){
    var.name <- var.names[i]
    query <- paste( query, '&', var.name, '=', variables[[ var.name ]], sep = "" )
  }
  return( query )
}

# Show endpoint for listing info on a variable
get.list.variable.endpoint <- function( variable.type ){
  name <- substitute( variable.type ) 
  return( VARIABLE.TYPES[[name]] )
}

# Perform call and convert data into data frame
perform.call <- function( call ){
  raw <- GET( call )
  data <- content( raw, "text" )
  converted <- fromJSON( data, flatten = TRUE)
  return( converted )
}

# Perform call and maintain jsonlite structure
perform.call.raw <- function( call ){
  raw <- GET( call )
  return( raw )
}

####
####
####

