source("R/endpoints.R")

#' Get all FIPS codes for each US state.
#' 
#' @export
#' @return API response containing states and their respective FIPS codes.
#' @examples
#' \dontrun{
#' state.fips <- get_state_fips()
#' state.fips$Data
#' }
get_state_fips <- function(){
  full.endpoint <- paste(LIST, STATES, sep="/")
  result <- perform.call(full.endpoint)
  return(result)
}

#' Get all counties within a state.
#' 
#' @export  
#' @param state.fips A state FIPS code. 
#' Use get_state_fips() to find the appropriate FIPS code.
#' @return API response containing all counties and 
#' county codes within a given state.
#' @examples
#' \dontrun{
#' state <- "37"
#' counties.in.state <- get_state_fips(state)
#' counties.in.state$Data
#' }
get_counties_in_state <- function(state.fips){
  full.endpoint <- paste(LIST, COUNTIES_BY_STATE, sep="/")
  result <- perform.call(full.endpoint, 
                         variables = list("state" = state.fips))
  return(result)
}

#' Get all measurement sites within a county.
#' 
#' @export
#' @param state.fips  A state FIPS code. 
#' Use get_state_fips() to find the appropriate FIPS code.
#' @param county.code A county code. 
#' Use get_counties_in_state() to find the appropriate code for a given county.
#' @return API response containing all measurement sites within a given county.
#' @examples
#' \dontrun{
#' state <- "37"
#' county.code <- "001"
#' measurement.sites <- get_sites_in_county(state, county.code)
#' measurement.sites$Data 
#' }
get_sites_in_county <- function(state.fips, county.code){
  full.endpoint <- paste(LIST, SITES_BY_COUNTY, sep="/")
  result <- perform.call(full.endpoint, 
                         variables = list("state" = state.fips, 
                                          "county" = county.code))
  return(result)
}

#' Get all Core Based Statistical Areas. 
#' 
#' @export
#' @return API response containing a list of all Core Based Statistical Areas.
#' @examples
#' \dontrun{
#' cbsas <- get_cbsas()
#' cbsas$Data
#' }
get_cbsas <- function(){
  full.endpoint <- paste(LIST, CBSAS, sep="/")
  result <- perform.call(full.endpoint)
  return(result)
}

#' Get all types of parameters. 
#' 
#' @export
#' @return API response containing types of 
#' parameters and their respective code.
#' @examples
#' \dontrun{
#' classes <- get_parameter_classes()
#' classes$Data
#' }
get_parameter_classes <- function(){
  full.endpoint <- paste(LIST, PARAMETER_CLASSES, sep="/")
  result <- perform.call(full.endpoint)
  return(result)
}

#' Get all parameters available within a particular parameter class.
#' 
#' @export
#' @param class A type of pollutant. 
#' Find types of pollutants with get_parameter_classes().
#' @return API response containing parameters 
#' found within a class/group of like parameters.
#' @examples 
#' \dontrun{
#' class <- "AQI POLLUTANTS"
#' parameters <- get_parameters_in_class(class)
#' parameters$Data
#' }
get_parameters_in_class <- function(class){
  full.endpoint <- paste(LIST, PARAMETERS_WITHIN_CLASS, sep="/")
  result <- perform.call(full.endpoint, 
                         variables = list("pc" = class))
  return(result)
}

#' Get Primary Quality Assurance Organizations. 
#' 
#' @export
#' @return API response containing all Primary Quality Assurance Organizations.
#' @examples
#' \dontrun{
#' pqaos <- get_all_pqaos()
#' pqaos$Data
#' }
get_all_pqaos <- function(){
  full.endpoint <- paste(LIST, PQAOS, sep="/")
  result <- perform.call(full.endpoint)
  return(result)
}

#' Get Monitoring Agencies.
#' 
#' @export
#' @return API response containing all Monitoring Agencies. 
#' @examples 
#' \dontrun{
#' mas <- get_all_mas()
#' mas$Data
#' }
get_all_mas <- function(){
  full.endpoint <- paste(LIST, MAS, sep="/")
  result <- perform.call(full.endpoint)
  return(result)
}
