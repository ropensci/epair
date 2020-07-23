#### This module was built to encapsulate the functions that scrape tables from the EPA API

#' Get an HTML table at URL
#'
#' @param url URL to get table from
#' @param table.xpath The X path to the table
#'
#' @return A data frame of the HTML table
#' @export
#'
#' @import magrittr
#'
#' @examples
#' \dontrun{
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- get.table(url, table.path)
#' df
#' }
get.table <- function(url, table.xpath) {
  found.table <- url %>%
    xml2::read_html() %>%
    rvest::html_nodes(xpath = table.xpath) %>% 
    rvest::html_table()
  return(found.table[[1]])
}

#' Get service names and descriptions to the services
#'
#' @return A data frame containing services with names and descriptions offered by the EPA API.
#' @export
#'
#' @examples
#' \dontrun{
#' service.names <- get.service.names()
#' service.names
#' }
get.service.names <- function() {
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table(url, table.path)
  
  t.df <- get.transpose(df)
  t.df <- remove.escapes.spaces(t.df)
  
  return(t.df)
}

#' Popoulate variables for info on making requests
#'
#' @return Data frame containing variables and information about them used in the EPA API.
#' @export
#'
#' @examples
#' \dontrun{
#' vars <- get.variables()
#' vars$edate
#' }
get.variables <- function() {
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[2]'
  df <- get.table(url, table.path)
  
  t.df <- get.transpose(df)
  t.df <- list.remove.escapes.spaces(t.df)
  
  return(t.df)
}

#' Get all endpoints from EPA API
#'
#' @return Vector of endpoints from the API
#' @export
#'
#' @examples
#' \dontrun{
#' endpoints <- get.endpoints()
#' endpoints
#' }
get.endpoints <- function() {
  API.tables <- get.all.tables()
  endpoints <- find.endpoints.in.tables(API.tables)
  return(endpoints)
}

#' Take a list of html tables from api and output all endpoints
#'
#' @param list.tables List of HTML tables from EPA API
#'
#' @return Vector with only endpoints for the API.
#' @export
#'
#' @examples
#' \dontrun{
#' API.tables <- get.all.tables()
#' endpoints <- find.endpoints.in.tables(API.tables)
#' endpoints
#' }
find.endpoints.in.tables <- function(list.tables) {
  endpoints <- c()
  for(i in 1:length(list.tables)) {
    if("Endpoint" %in% colnames(list.tables[[i]])) {
      endpoints <- c(endpoints, list.tables[[i]]$Endpoint) 
    }
  }
  # Don't insert entries that aren't endpoints
  pure.endpoints <- c()
  for(i in 1:length(endpoints)) {
    if(!endpoint.checker(endpoints[i])) {
      pure.endpoints <- c(pure.endpoints, endpoints[i])
    }
  }
  return(pure.endpoints)
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
#' \dontrun{
#' get.list.variable.endpoint("state")
#' get.list.variable.endpoint("classes")
#' }
get.list.variable.endpoint <- function(variable.type, variable.types) {
  name <- substitute(variable.type) 
  return(variable.types[[name]])
}

#' Check if a string contains characters not seen in endpoints
#'
#' @param string A character entry from entries in the data frame of API services
#'
#' @return A boolean reflecting presence of endpoint in string
#' @export
#'
#' @examples
#' endpoint.checker("list/states")
#' endpoint.checker("https://example here")
endpoint.checker <- function(string) {
  example.check <- grepl("Example", string, fixed = TRUE)
  returns.check <- grepl("Returns", string, fixed = TRUE)
  https.check <- grepl("https:", string, fixed = TRUE)
  return(example.check | returns.check | https.check)
}

#' Get all the html tables in the API site
#'
#' @return A list of HTML tables from the EPA API site. 
#' @export
#'
#' @examples
#' \dontrun{
#' html.tables.list <- get.all.table()
#' html.tables.list
#' }
get.all.tables <- function() {
  site <- xml2::read_html('https://aqs.epa.gov/aqsweb/documents/data_api.html')
  tbls <- rvest::html_nodes(site, "table")
  list.tbls <- rvest::html_table(tbls, fill = TRUE)
  return(list.tbls)
}

#' Get a list of services the EPA API offers
#'
#' @return List of services the EPA API offers.
#' @export
#' 
#' @import magrittr
#'
#' @examples
#' \dontrun{
#' services <- get.services()
#' services
#' }
get.services <- function() {
  tbls <- get.all.tables()
  # Service, variables, and sign up services removed
  tbls <- tbls[-c(1, 2, 3)]
  
  # Turn HTML tables into a workable variable
  services <- populate.all.services(tbls) %>%
    assign.description.to.services() %>%
    list.remove.escapes.spaces() %>%
    change.classes.filter
  
  return(services)
}