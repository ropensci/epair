#### This module was built to encapsulate the functions that scrape tables from the EPA API

#' Get an HTML table at URL
#'
#' @param url URL to get table from
#' @param table.xpath The X path to the table
#'
#' @return A data frame of the HTML table
#'
#' @examples
#' \dontrun{
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- epair:::get.table(url, table.path)
#' df
#' }
get.table <- function(url, table.xpath) {
  site <- xml2::read_html(url)
  found.table <- rvest::html_nodes(site, xpath = table.xpath)
  found.table <- rvest::html_table(found.table)
  return(found.table[[1]])
}

#' Get service names and descriptions to the services
#'
#' @return A data frame containing services with names and descriptions offered by the EPA API.
#'
#' @examples
#' \dontrun{
#' service.names <- epair:::get.service.names()
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

#' Populate variables for info on making requests
#'
#' @return Data frame containing variables and information about them used in the EPA API.
#' @export
#'
#' @examples
#' \dontrun{
#' vars <- epair:::get.variables()
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
#'
#' @examples
#' \dontrun{
#' endpoints <- epair:::get.endpoints()
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
#'
#' @examples
#' \dontrun{
#' API.tables <- epair:::get.all.tables()
#' endpoints <- epair:::find.endpoints.in.tables(API.tables)
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
    if(!non.endpoint.checker(endpoints[i])) {
      pure.endpoints <- c(pure.endpoints, endpoints[i])
    }
  }
  return(pure.endpoints)
}

#' Check if a string contains characters not seen in endpoints
#'
#' @param string A character entry from entries in the data frame of API services
#'
#' @return A boolean reflecting presence of endpoint in string.
#'
#' @examples
#' epair:::non.endpoint.checker("list/states")
#' epair:::non.endpoint.checker("https://example here")
non.endpoint.checker <- function(string) {
  example.check <- grepl("Example", string, fixed = TRUE)
  returns.check <- grepl("Returns", string, fixed = TRUE)
  https.check <- grepl("https:", string, fixed = TRUE)
  return(example.check | returns.check | https.check)
}

#' Get all the html tables in the API site
#'
#' @return A list of HTML tables from the EPA API site. 
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
#'
#' @examples
#' \dontrun{
#' services <- epair:::get.services()
#' services
#' }
get.services <- function() {
  tbls <- get.all.tables()
  # Service, variables, and sign up services removed
  tbls <- tbls[-c(1, 2, 3)]
  
  # Turn HTML tables into a workable variable
  services <- populate.all.services(tbls)
  services <- assign.description.to.services(services)
  services <- list.remove.escapes.spaces(services)
  services <- change.classes.filter(services)
  return(services)
}
