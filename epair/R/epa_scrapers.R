#### This module was built to encapsulate the functions that scrape tables from the EPA API

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
    xml2::read_html() %>%
    rvest::html_nodes( xpath = table.xpath ) %>% 
    rvest::html_table()
  return( found.table[[1]] )
}

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
  site <- xml2::read_html( 'https://aqs.epa.gov/aqsweb/documents/data_api.html' )
  tbls <- rvest::html_nodes( site, "table" )
  list.tbls <- rvest::html_table(tbls, fill = TRUE)
  return( list.tbls )
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
    change.classes.filter
  
  return( services )
}