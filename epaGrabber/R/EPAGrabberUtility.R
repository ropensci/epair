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
#' services <- get.services()
#' services <- list.string.replacer( services, "\t", "")
#' services
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
#' services <- get.services()
#' services <- list.remove.escapes.spaces( services )
#' services
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
#' service.names <- get.service.names()
#' service.names
get.service.names <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table( url, table.path )
  
  t.df <- get.transpose( df )
  t.df <- remove.escapes.spaces( t.df )
  
  return( t.df )
}

#' Popoulate VARIABLES for info on making requests
#'
#' @return Data frame containing variables and information about them used in the EPA API.
#' @export
#'
#' @examples
#' vars <- get.variables()
#' vars$edate
get.variables <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[2]'
  df <- get.table( url, table.path )
  
  t.df <- get.transpose( df )
  t.df <- list.remove.escapes.spaces( t.df )
  
  return( t.df )
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
#' @param variable.types A list contianing variable types mapped to their endpoints. This vector 
#' should be loaded in with the package and can be found in the package data files. Type ?variable.types
#' for more info.
#' 
#' @return An endpoint character that lists information to help the user query a variable.
#' @export
#'
#' @examples
#' get.list.variable.endpoint( "state" )
#' get.list.variable.endpoint( "classes" )
get.list.variable.endpoint <- function( variable.type, variable.types ){
  name <- substitute( variable.type ) 
  return( variable.types[[name]] )
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
  service.names <- get.service.names()
  # Remove the signup since the user will do that via the website
  no.sign.up.services <- service.names[-1]
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
  tbls <- tbls[-c(1, 2, 3)]    # Service, variables, and sign up services removed
  
  # Turn HTML tables into a workable variable
  services <- populate.all.services( tbls ) %>%
    assign.description.to.services() %>%
    list.remove.escapes.spaces() %>%
    change.classes.filter()
  
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

#' Get filter names in data frame
#'
#' @param df Data frame containing repeated or mixed filter names.
#'
#' @return Vector containing only filter names for the API service. Service name 
#' and repeated filter names are removed. 
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[6]]
#' get.true.filters( single )
get.true.filters <- function( df ){
  service.name <- df$Service[1]
  unique.filters <- unique( df$Filter )
  unique.filters <- unique.filters[which( unique.filters != service.name )]
  return( unique.filters )
}

#' Get the first entry for a filter name
#'
#' @param filter.name Name of the filter in API
#' @param df Data frame containing filter info.
#'
#' @return The index for the first occurence of the filter in the data frame.
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[11]]
#' get.first.entry.for.filter( "Filter Name", single )
get.first.entry.for.filter <- function( filter.name, df ){
  indices <- which( df$Filter == filter.name)
  first.occurence <- min( indices )
  return( first.occurence )
}

#' Get first entries for filter names
#'
#' @param df Data frame with filters
#'
#' @return A vector of indices. These indices are where the first entry for a filter 
#' exists in df. 
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[10]]
#' first.occurences <- get.first.occurences( single )
get.first.occurences <- function( df ){
  true.filters <- get.true.filters( df )
  first.occurences <- sapply( true.filters, get.first.entry.for.filter, df)
  return( first.occurences )
}

#' Generate filter content for an API filter
#'
#' @param i Row number at which to get the information for filter.
#' @param df The data frame containing filter information.
#'
#' @return A list with filter content (endpoint, required variables, etc.)
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[7]]
#' content <- generate.filter.content( 1, single )
generate.filter.content <- function( i, df){
  filter.content <- list( Endpoint = df$Endpoint[i],
                          RequiredVariables = df$`Required Variables`[i],
                          OptionalVariables = df$`Optional Variables`[i],
                          Example = df$Endpoint[i + 1])
  return( filter.content )
}

#' Create a single filter 
#'
#' @param filter.name Name of filter in API service
#' @param i Row number to use to create filter. Make sure filter information is 
#' present at i before hand.
#' @param df Data frame with filter information.
#'
#' @return A list with filter content given to the filter name.
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[9]]
#' filter.name <- "My filter"
#' setup.single.filter( filter.name, 1, single)
setup.single.filter <- function( filter.name, i, df ){
  filter.content <- generate.filter.content( i, df )
  filter.out <- list()
  filter.out[[filter.name]] <- filter.content
  return( filter.out )
}

#' Create a list of filters
#'
#' @param df A data frame having filter information (e.g. name, required variables).
#'
#' @return A list containing filters and respective info. 
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[8]]
#' generate.filters.list( single )
generate.filters.list <- function( df ){
  filters.list <- list()
  first.occurences <- get.first.occurences( df )
  n = length(first.occurences)
  for( i in 1:n){
    filter.name <- names(first.occurences)[i]
    filter.index <- first.occurences[[i]]
    filter.out <- setup.single.filter( filter.name, filter.index, df)
    filters.list <- c( filters.list, filter.out)
  }
  return( filters.list )
}

#' Make list of single service
#'
#' @param df Data frame with info to make an API service. 
#'
#' @return A list with the filter content of a service set to the service name.
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[8]]
#' setup.service( single )
setup.service <- function( df ){
  service.list <- list()
  service.name <- df$Service[1]
  filter.list <- list()
  filter.list[["Filters"]] <- generate.filters.list( df )
  service.list[[service.name]] <- filter.list
  return(service.list)
}

#' Turn tables of API services into a list
#'
#' @param tables.to.modify List of tables from API. Each table is a data frame.  
#'
#' @return A list with each service and filters as chained variables to make for easy calling.
#' @export
#'
#' @examples
#' tables.to.modify <- get.all.tables()
#' services <- populate.all.services( tables.to.modify )
#' services$List
populate.all.services <- function( tables.to.modify ){
  service.list <- list()
  for( i in 1:length(tables.to.modify)){
    df <- tables.to.modify[[i]]
    single.service <- setup.service( df )
    service.list <- c( service.list, single.service)
  }
  return(service.list)
}
