## Utility package for creating queries in EPA API 
## at https://aqs.epa.gov/aqsweb/documents/data_api.html#signup


EMAIL <- ''
KEY <-  ''
AUTHENTICATION <- ''
SERVICES <- list()
SERVICE.NAMES <- data.frame()
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
get.service.names <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table( url, table.path )
  
  df <- remove.escapes.spaces( df )
  
  t.df <- get.transpose(df)
  
  SERVICE.NAMES <<- t.df
  return( t.df )
}

## TODO setup assert to ensure services are present
show.service.names <- function(){
  print( colnames( SERVICE.NAMES ) )
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

# Check if a string contains characters not seen in endpoints
endpoint.checker <- function( string ){
  example.check <- grepl( "Example", string, fixed = TRUE)
  returns.check <- grepl( "Returns", string, fixed = TRUE)
  https.check <- grepl( "https:", string, fixed = TRUE)
  return( example.check | returns.check | https.check)
}

# Function that replaces overflow entries (for filter)
# TODO, generalize to variable
correct.overflow.filter <- function( df  ){
  copy.df <- df
  for( i in 1:length( df$Filter) ){
    if( df$Filter[i] == df$Service[1]){     # Assume that the service entry overflowed into the filter
      copy.df$Filter[i] <- df$Filter[i - 1] # Assign the previous entry, still in same filter
    }
  }
  return( copy.df )
}

#### Find out if a string has Example in it
#### --> For finding the examples in the entries
example.check <- function( string ){
  return( grepl("Example", string, fixed = TRUE) )
}


#### Function to give to list structure creator
create.list.endpoints.examples.params <- function( row.number, df ){
  test.list <- list()
  if( ! example.check( df$Endpoint[row.number]) ){
    # Add the endpoint to the endpoint reading
    test.list$Endpoint <- df$Endpoint[row.number]
  }
  if( ! example.check( df$'Required Variables'[row.number]) ){
    test.list$RequiredVariables <- df$'Required Variables'[row.number]
  }
  
  if( ! is.na( df$'Optional Variable'[ row.number ]) ){
    if( ! example.check( df$`Optional Variables`[row.number]) & df$'Optional Variables'[row.number] != ""){
      # Add the param variables there
      test.list$OptionalVariables <- df$`Optional Variables`[row.number]
    }
  }
  if( example.check( df$Endpoint[row.number]  ) ){
    test.list$Example <- df$Endpoint[row.number] # Should be an example
  }
  test.list
  return( test.list )
}
# result.list <- create.list.endpoints.examples.params( 8, copy.table)
# result.list$Example
####

### Modify to pass in table, find the indices at which a filter exists
determine.filter <- function( name.filter, df ){
  indices <- which(df$Filter == name.filter)
  return( indices )
}

#### Find the counts for each filter entry, (assumes the filter has been cleaned
create.filter.list <- function( df ){ # df contains a filter variable
  
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

# Take a df and output a list with easy accessing for variables
populate.service.list <- function( df ){
  corrected.df <- df
  result.list <- list()
  
  result.list$Service <- df$Service[1]
  corrected.df <- correct.overflow.filter( df )
  
  result.list$Filter <- create.filter.list( corrected.df )
  
  return( result.list )
}

# Take a list of html tables, output a list of lists, each list a service.
populate.all.services <- function( list.tables ){
  services.list <- list()
  for( i in 1:length( list.tables ) ){
    df <- list.tables[[i]]
    if(  length( df$Filter ) != 0  ) { # Esnure all services going into final list have a filter
      if( !is.na( df$Filter )[1] ) {
        service.name <- df$Service[1]
        services.list[[ service.name ]] <- populate.service.list( df )
      }
    }
  }
  return( services.list )
}

# Take a list of html tables from api and output all endpoints
show.endpoints <- function( list.tables ){
  endpoints <- c()
  for( i in 1:length( list.tables ) ){
    if( "Endpoint" %in% colnames( list.tables[[i]] ) ){
      endpoints <- c( endpoints, list.tables[[i]]$Endpoint ) 
    }
  }
  # Filter out entries that aren't endpoints
  pure.endpoints <- c()
  for( i in 1:length( endpoints ) ){
    if( !endpoint.checker( endpoints[i] ) ){
      pure.endpoints <- c( pure.endpoints, endpoints[i])
    }
  }
  return( pure.endpoints )
}

# Get all the html tables in the API site and return a list with tables
# -- Be sure bug in rvest has been fixed
get.all.tables <- function( ){
  site <- read_html( 'https://aqs.epa.gov/aqsweb/documents/data_api.html' )
  tbls <- html_nodes( site, "table" )
  list.tbls <- html_table(tbls, fill = TRUE)
  return( list.tbls )
}

# Assign a description to each service using the service and description table
assign.description.to.services <- function( services ){
  if( length( SERVICE.NAMES) == 0){
    stop( "Fill up SERVICE.NAMES by calling get.service.names()")
  }
  # Remove the signup since the user will do that via the website
  no.sign.up.services <- SERVICE.NAMES[-1]
  for(i in 1:length( no.sign.up.services )){
    services[[i]]$Description <- no.sign.up.services[[i]][2]    # Second entry is description
  }
  return( services )
}

# Assign description to services in list structure
get.services <- function(){
  if( length( SERVICE.NAMES)  == 0){
    stop( "Must populate SERVICE.NAMES with names and descriptions of service.")
  }
  tbls <- get.all.tables()
  services <- populate.all.services( tbls )
  services <- assign.description.to.services( services )
  
  SERVICES <<- services
  
  return( services )
}

####
####
####



