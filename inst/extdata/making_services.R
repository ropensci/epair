#### This module was built to contain functions related to building the services variable. 
#### This services variables includes services offered by the EPA API, except for sign up.

#' Turn tables of API services into a list
#'
#' @param tables.to.modify List of tables from API. Each table is a data frame.  
#'
#' @return A list with each service and filters as chained variables to make for easy calling.
#'
#' @examples
#' \dontrun{
#' tables.to.modify <- get.all.tables()
#' services <- populate.all.services(tables.to.modify)
#' services$List
#' }
populate.all.services <- function(tables.to.modify) {
  service.list <- list()
  for(i in 1:length(tables.to.modify)) {
    df <- tables.to.modify[[i]]
    single.service <- setup.service(df)
    service.list <- c(service.list, single.service)
  }
  return(service.list)
}

#' Make list of single service
#'
#' @param df Data frame with info to make an API service. 
#'
#' @return A list with the filter content of a service set to the service name.
#'
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[8]]
#' setup.service(single)
#' }
setup.service <- function(df) {
  service.list <- list()
  service.name <- df$Service[1]
  filter.list <- list()
  filter.list[["Filters"]] <- generate.filters.list(df)
  service.list[[service.name]] <- filter.list
  return(service.list)
}

#' Get filter names in data frame
#'
#' @param df Data frame containing repeated or mixed filter names.
#'
#' @return Vector containing only filter names for the API service. Service name 
#' and repeated filter names are removed. 
#'
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[6]]
#' get.unique.filters(single)
#' }
get.unique.filters <- function(df) {
  if("Filter" %in% names(df)) { 
    service.name <- df$Service[1]
    unique.filters <- unique(df$Filter)
    unique.filters <- unique.filters[which(unique.filters != service.name)]
    return(unique.filters)
  } else {
    return("This table doesn't contain filters!")
  }
}

#' Update name to parameter class entry
#' 
#' As of this package release, a service in the API was incorrectly described
#' in the original website. This function gives the services variable the proper information
#' describing usage of the service.
#'
#' @param services List of services offered by the API.
#' 
#' @return Services with corrected name of filter for parameter classes. 
#'
#' @examples
#' \dontrun{
#' services <- get.services()
#' services <- change.classes.filter(services)
#' services$List$Filter$`Parameter Classes (groups of parameters, like criteria or all)`
#' }
change.classes.filter <- function(services) {
  names(services$List$Filters)[5] <- "Parameter Classes (groups of parameters, like criteria or all)"
  
  service.attributes <- list(Endpoint = "list/classes",
                             RequiredVariables = "email, key",
                             OptionalVariables = "",
                             Example = "https://aqs.epa.gov/data/api/list/classes?email=test@aqs.api&key=test")
  services$List$Filters$`Parameter Classes (groups of parameters, like criteria or all)` <- service.attributes
  return(services)
}

#' Assign a description to each service
#'
#' @param services A list of services offered by the EPA API. 
#'
#' @return The list of services with descriptions for each service.
#'
#' @examples
#' \dontrun{
#' services <- assign.description.to.services(services)
#' services[[1]]$Description
#' }
assign.description.to.services <- function(services) {
  service.names <- get.service.names()
  # Remove the signup since the user will do that via the website
  no.sign.up.services <- service.names[-1]
  for(i in 1:length(no.sign.up.services)) {
    # Second entry is description
    services[[i]]$Description <- no.sign.up.services[[i]][2]
  }
  return(services)
}

#' Get the first entry for a filter name
#'
#' @param filter.name Name of the filter in API
#' @param df Data frame containing filter info.
#'
#' @return The index for the first occurrence of the filter in the data frame.
#'
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[11]]
#' get.first.entry.for.filter("Filter Name", single)
#' }
get.first.entry.for.filter <- function(filter.name, df) {
  indices <- which(df$Filter == filter.name)
  first.occurence <- min(indices)
  return(first.occurence)
}

#' Generate filter content for an API filter
#'
#' @param i Row number at which to get the information for filter.
#' @param df The data frame containing filter information.
#'
#' @return A list with filter content (endpoint, required variables, etc.)
#' 
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[7]]
#' content <- generate.filter.content(1, single)
#' }
generate.filter.content <- function(i, df) {
  filter.content <- list(Endpoint = df$Endpoint[i],
                         RequiredVariables = df$`Required Variables`[i],
                         OptionalVariables = df$`Optional Variables`[i],
                         Example = df$Endpoint[i + 1])
  return(filter.content)
}

#' Get first entries for filter names
#'
#' @param df Data frame with filters
#'
#' @return A vector of indices. These indices are where the first entry for a filter 
#' exists in the data frame. 
#'
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[10]]
#' first.occurrences <- get.first.entries(single)
#' }
get.first.entries <- function(df) {
  true.filters <- get.unique.filters(df)
  first.occurences <- sapply(true.filters, get.first.entry.for.filter, df)
  return(first.occurences)
}

#' Create a single filter 
#'
#' @param filter.name Name of filter in API service
#' @param i Row number to use to create filter. Make sure filter information is 
#' present at i before hand.
#' @param df Data frame with filter information.
#'
#' @return A list with filter content given to the filter name.
#'
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[9]]
#' filter.name <- "My filter"
#' setup.single.filter(filter.name, 1, single)
#' }
setup.single.filter <- function(filter.name, i, df) {
  filter.content <- generate.filter.content(i, df)
  filter.out <- list()
  filter.out[[filter.name]] <- filter.content
  return(filter.out)
}

#' Create a list of filters
#'
#' @param df A data frame having filter information (e.g. name, required variables).
#'
#' @return A list containing filters and respective info. 
#'
#' @examples
#' \dontrun{
#' tbls <- get.all.tables()
#' single <- tbls[[8]]
#' generate.filters.list(single)
#' }
generate.filters.list <- function(df) {
  filters.list <- list()
  first.occurences <- get.first.entries(df)
  n = length(first.occurences)
  for(i in 1:n){
    filter.name <- names(first.occurences)[i]
    filter.index <- first.occurences[[i]]
    filter.out <- setup.single.filter(filter.name, filter.index, df)
    filters.list <- c(filters.list, filter.out)
  }
  return(filters.list)
}