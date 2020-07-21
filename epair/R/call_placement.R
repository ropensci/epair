#### This module was built to encapsulate call placement functions to the EPA API

#' Check if the API is up and running 
#'
#' 
#' @export
#'
#' @examples
#' is.API.running()
is.API.running <- function(){
  endpoint <-  'metaData/isAvailable'
  url <- create.base.call( endpoint  )
  raw <- httr::GET( url )
  text.content <- httr::content( raw, "text" )
  converted <- jsonlite::fromJSON( text.content, flatten = TRUE )
  
  print( converted$Header$status )
  print( converted$Header$request_time)
}

#' Perform call and keep original result
#'
#' @param call URL following structure from EPA API
#'
#' @return A list containing result from query to EPA API
#' @export
#'
#' @examples
#' endpoint <- 'list/states'
#' result <- perform.call.raw(endpoint)
perform.call.raw <- function( endpoint, variables = list(), name = deparse( substitute( variables ) )  ){
  
  # The user passed no variables 
  if( length(variables) == 0){
    call <- create.base.call( endpoint )
    result <- place.call.raw( call )
    return( result )
  }
  
  # The user passed a single variable
  if( class(variables) == "character"){
    call <- create.base.call( endpoint )
    call <- add.variable( call, variables, name )
    result <- place.call.raw( call )
    return( result )
  }
  
  # The user passed multiple variables as a list
  call <- create.base.call( endpoint )
  call <- add.variables( call, variables )
  result <- place.call.raw( call )
  return( result )
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
#' result <- perform.call(endpoint)
#' 
perform.call <- function( endpoint, variables = list(), name = deparse( substitute( variables ) )  ){
  
  # The user passed no variables 
  if( length(variables) == 0){
    call <- create.base.call( endpoint )
    result <- place.call( call )
    return( result )
  }
  
  # The user passed a single variable
  if( class(variables) == "character"){
    call <- create.base.call( endpoint )
    call <- add.variable( call, variables, name )
    result <- place.call( call )
    return( result )
  }
  
  # The user passed multiple variables as a list
  call <- create.base.call( endpoint )
  call <- add.variables( call, variables )
  result <- place.call( call )
  return( result )
}


#' Place the URL as a call to the EPA API
#'
#' @param url A string with a valid URL for the EPA API
#'
#' @return Result of query from the API
#' @export
#'
#' @examples
#' url <- "user_url"
#' result <- place.call(url)
#' 
place.call <- function( url ){
  raw <- httr::GET( url )
  data <- httr::content( raw, "text" )
  converted <- jsonlite::fromJSON( data, flatten = TRUE)
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
place.call.raw <- function( url ){
  result <- httr::GET( url )
  return( result )
}