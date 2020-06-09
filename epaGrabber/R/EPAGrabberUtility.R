## Utility file for creating queries in EPA API at https://aqs.epa.gov/aqsweb/documents/data_api.html

# Bug in rvest, code must be fixed to contain this line.
# if (j+k > nrow(out)) break;
# fixInNamespace("html_table.xml_node", "rvest")

####
#### Authentication 
####

#' Generate the string authentication needed for EPA API
#'
#' @param email Email registered with EPA API
#' @param key Key obtained from EPA API. Register your email for a key here 
#' https://aqs.epa.gov/aqsweb/documents/data_api.html#signup.
#'
#' @return
#' @export
#'
#' @examples
#' create.authentication( "myemail@domain.com", "myapikey")
create.authentication <- function( email, key){
  authentication.string <- sprintf('&email=%s&key=%s', email, key)
  return( authentication.string )
}


####
####
####

####
#### Calls 
####

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
create.base.call <- function( endpoint ){
  if( length( getOption( "epa_authentication") ) == 0 ){
    stop( "Make sure you've declared the option for epa_authentication.")
  }
  base = 'https://aqs.epa.gov/data/api/'
  result <- paste( base, endpoint, "?", getOption( "epa_authentication" ), sep = "")
  return( result )
}



####
#### Site scraping and data transformation
####

#' Get an HTML table at URL
#'
#' @param url URL to get table from
#' @param table.xpath The X path to the table
#'
#' @return A data frame of the HTML table
#' @export
#'
#' @examples
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- get.table( url, table.path )
#' df
get.table <- function( url, table.xpath ){
  found.table <- url %>%
    read_html() %>%
    html_nodes( xpath = table.xpath ) %>% 
    html_table()
  return( found.table[[1]] )
}


#' Replace all characters entries in df
#'
#' @param df Data frame containing character entries
#' @param pattern Pattern to use for matching
#' @param replacement Replacement of entries matching pattern
#'
#' @return A data frame with entries following the pattern being replaced by replacement
#' @export
#'
#' @examples
#' df <- data.frame( c("1", "2", "3", "4"))
#' modified.df <- string.replacer( df, "1", "One")
#' modified.df
string.replacer <- function( df, pattern, replacement){
  modified.df <- lapply( df, gsub, pattern = pattern, replacement = replacement, fixed = TRUE)
  return( as.data.frame( modified.df ) )
}

#' Replace every string entry in a list 
#'
#' @param entry.list List containing character entries
#' @param pattern Pattern to replace
#' @param replacement Replacement for entries following the pattern
#'
#' @return A list with entries matching the pattern replaced by replacement
#' @export
#'
#' @examples
#' get.services()
#' SERVICES <- list.string.replacer( SERVICES, "\t", "")
list.string.replacer <- function( entry.list, pattern, replacement ){
  new.list <- rapply( entry.list, 
                      gsub, 
                      pattern = pattern, 
                      replacement = replacement, 
                      fixed = TRUE,
                      how = "replace")
  return( new.list )
}

#' Remove '\t', '\r\n', "   " from entries in a data frame
#'
#' @param df Data frame to remove '\t', '\r\n', "   " from
#'
#' @return Data frame without '\t', '\r\n', "   "
#' @export
#'
#' @examples
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- get.table( url, table.path )
#' df
#' 
#' clean.df <- remove.escapes.spaces( df )
#' clean.df
remove.escapes.spaces <- function( df ){
  clean.df <- string.replacer( df, "\t", "") %>%
    string.replacer( "\r\n", "") %>%
    string.replacer( "   ", "")
  return( clean.df )
}

#' Remove '\t', '\r\n', "   " from entries in a list
#'
#' @param a.list List to remove entries from.
#'
#' @return A list without '\t', '\r\n' and "  "
#' @export
#'
#' @examples
#' get.services()
#' SERVICES <- list.remove.escapes.spaces( SERVICES )
#' SERVICES
list.remove.escapes.spaces <- function( a.list ){
  new.list <- list.string.replacer( a.list, "\t", "") %>%
    list.string.replacer( "\r\n", "") %>%
    list.string.replacer( "   ", "")
  return( new.list )
}

#' Transpose a data frame
#'
#' @param df Data frame to be transposed
#'
#' @return The transposed data frame. First variable entries become column names.
#' @export
#'
#' @examples
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- get.table( url, table.path )
#' t.df <- get.transpose( df )
#' t.df
get.transpose <- function( df  ){
  t.df <-  t( df )
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

#' Get service names and descriptions to the services
#'
#' @return A data frame containing services with names and descriptions offered by the EPA API.
#' @export
#'
#' @examples
#' get.service.names()
#' SERVICE.NAMES
get.service.names <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table( url, table.path )
  
  t.df <- get.transpose( df )
  t.df <- remove.escapes.spaces( t.df )
  
  SERVICE.NAMES <<- t.df
  return( t.df )
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

#' Popoulate VARIABLES for info on making requests
#'
#' @return Data frame containing variables and information about them used in the EPA API.
#' @export
#'
#' @examples
#' get.variables()
#' VARIABLES$edate
get.variables <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[2]'
  df <- get.table( url, table.path )
  
  t.df <- get.transpose( df )
  t.df <- list.remove.escapes.spaces( t.df )
  
  VARIABLES <<- t.df
  return( t.df )
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

#' Check if the API is up and running 
#'
#' @return Json result showing whether the API is up.
#' @export
#'
#' @examples
#' is.API.running()
is.API.running <- function(){
  endpoint <-  'metaData/isAvailable'
  url <- create.base.call( endpoint  )
  result <- GET( url )
  return( result )
}

#' Add a variable to a call
#'
#' @param query A URL containing authentication for EPA API
#' @param variable A variable for a call. Consult VARIABLE.TYPES for possible variables. 
#' @param name Default argument should be left as is. Will take the name used for variable above
#' to create the final URL.
#'
#' @return A URL containing query + variable.
#' @export
#'
#' @examples
#' endpoint <- 'dailyData/byState'
#' state <- "37"
#' call <- create.base.call( endpoint )
#' call <- add.variable( call, state )
#' call     # Call requires more variables before being placed
add.variable <- function( query, variable, name = deparse( substitute( variable ) ) ){
  result <- paste( query, '&', name, '=', variable, sep = "" )
  return( result )
}

#' Add variables to a query
#'
#' @param query A URL containing authentication for the EPA API site.
#' @param variables A list of variables. Each variable should be declareed with the approporiate name.
#' Consult VARIABLE.TYPES for the right names.
#'
#' @return A URL consisting of query + variables.
#' @export
#'
#' @examples
#' endpoint <- 'dailyData/byState'
#' variable.list <- list( "state" = '37', 
#'                       "bdate" = '20200101', 
#'                       "edate" = '20200102', 
#'                       "param" = '44201')
#' call <- create.base.call( endpoint )
#' call <- add.variables( call, variable.list )
#' call
add.variables <- function( query, variables ){
  var.names <- names( variables )
  for( i in 1:length( variables ) ){
    var.name <- var.names[i]
    query <- paste( query, '&', var.name, '=', variables[[ var.name ]], sep = "" )
  }
  return( query )
}

#' Show endpoint for listing information on a variable
#'
#' @param variable.type A variable used in the EPA API service. Consult VARIABLE.TYPES for available variables.
#' 
#' @return An endpoint character that lists information to help the user query a variable.
#' @export
#'
#' @examples
#' get.list.variable.endpoint( "state" )
#' get.list.variable.endpoint( "classes" )
get.list.variable.endpoint <- function( variable.type ){
  name <- substitute( variable.type ) 
  return( VARIABLE.TYPES[[name]] )
}

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

#' Perform call and maintain jsonlite structure
#'
#' @param call URL following structure from EPA API
#'
#' @return Results of data request in json format
#' @export
#'
#' @examples
#' endpoint <- 'list/states'
#' call <- create.base.call( endpoint )
#' raw.call <- perform.call.raw( call )
#' raw.call
perform.call.raw <- function( call ){
  raw <- GET( call )
  return( raw )
}



#' Check if a string contains characters not seen in endpoints
#'
#' @param string A character entry from entries in the data frame of API services
#'
#' @return A boolean reflecting presence of endpoint in string
#' @export
#'
#' @examples
#' endpoint.checker( "list/states" )
#' endpoint.checker( "https://example here")
endpoint.checker <- function( string ){
  example.check <- grepl( "Example", string, fixed = TRUE)
  returns.check <- grepl( "Returns", string, fixed = TRUE)
  https.check <- grepl( "https:", string, fixed = TRUE)
  return( example.check | returns.check | https.check)
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
  test.list
  return( test.list )
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


#' Take a list of html tables from api and output all endpoints
#'
#' @param list.tables List of HTML tables from EPA API
#'
#' @return Vector with only endpoints for the API.
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' endpoints <- find.endpoints.in.tables( API.tables )
#' endpoints
find.endpoints.in.tables <- function( list.tables ){
  endpoints <- c()
  for( i in 1:length( list.tables ) ){
    if( "Endpoint" %in% colnames( list.tables[[i]] ) ){
      endpoints <- c( endpoints, list.tables[[i]]$Endpoint ) 
    }
  }
  # Don't insert entries that aren't endpoints
  pure.endpoints <- c()
  for( i in 1:length( endpoints ) ){
    if( !endpoint.checker( endpoints[i] ) ){
      pure.endpoints <- c( pure.endpoints, endpoints[i])
    }
  }
  return( pure.endpoints )
}

#' Get all endpoints from EPA API
#'
#' @return Vector of endpoints from the API
#' @export
#'
#' @examples
#' endpoints <- get.endpoints()
#' endpoints
get.endpoints <- function(){
  API.tables <- get.all.tables()
  endpoints <- find.endpoints.in.tables( API.tables )
  return( endpoints )
}


#' Get all the html tables in the API site
#'
#' @return A list of HTML tables from the EPA API site. 
#' @export
#'
#' @examples
#' html.tables.list <- get.all.table()
#' html.tables.list
get.all.tables <- function( ){
  site <- read_html( 'https://aqs.epa.gov/aqsweb/documents/data_api.html' )
  tbls <- html_nodes( site, "table" )
  list.tbls <- html_table(tbls, fill = TRUE)
  return( list.tbls )
}

#' Assign a description to each service using SERVICE.NAMES
#'
#' @param services A list of services offered by the EPA API. 
#'
#' @return The list of services with descriptions for each service.
#' @export
#'
#' @examples
#' services <- assign.description.to.services( services )
#' services[[1]]$Description
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

#' Get a list of services the EPA API offers
#'
#' @return List of services the EPA API offers.
#' @export
#'
#' @examples
#' services <- get.services()
#' services
get.services <- function(){
  # Get HTML tables
  tbls <- get.all.tables()
  
  # Turn HTML tables into a workable variable
  services <- populate.all.services( tbls )
  services <- assign.description.to.services( services )
  
  services <- list.remove.escapes.spaces( services )
  services <- remove.all.service.names( services )
  
  services <- change.classes.filter( services )
  
  return( services )
}

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
