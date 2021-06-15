#### This module was built to encapsulate call placement functions to the EPA API

#' Check if the API is up and running 
#'
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' is.API.running()
#' }
is.API.running <- function() {
  endpoint <-  'metaData/isAvailable'
  url <- create.base.call(endpoint)
  raw <- httr::GET(url)
  text.content <- httr::content(raw, "text")
  converted <- jsonlite::fromJSON(text.content, flatten = TRUE)
  print(converted$Header$status)
  print(converted$Header$request_time)
}

#' Perform call and keep original result
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the EPA API endpoint. 
#' @param name Specifies the name each variable should have when placed in the URL. User input
#' is not necessary and should be left in default state.
#' 
#' @return A list containing result from query to EPA API
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' result <- perform.call.raw(endpoint)
#' }
perform.call.raw <- function(endpoint, variables = list()) {
  if(length(variables) == 0) {
    call <- create.base.call(endpoint)
    result <- place.call.raw(call)
    return(result)
  }
  
  call <- create.base.call(endpoint)
  call <- add.variables(call, variables)
  result <- place.call.raw(call)
  return(result)
}


#' Perform call and convert data into list
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the EPA API endpoint. 
#' @param name Specifies the name each variable should have when placed in the URL. 
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' result <- perform.call(endpoint)
#' }
perform.call <- function(endpoint, variables = list()) {
  
  if(length(variables) == 0) {
    call <- create.base.call(endpoint)
    result <- place.call(call)
    return(result)
  }
  
  call <- create.base.call(endpoint)
  call <- add.variables(call, variables)
  result <- place.call(call)
  return(result)
}


#' Place the URL as a call to the EPA API
#'
#' @param url A string with a valid URL for the EPA API
#'
#' @return Result of query from the API
#'
#' @examples
#' \dontrun{
#' url <- "user_url"
#' result <- place.call(url)
#' }
place.call <- function(url) { 
  raw <- httr::GET(url)
  data <- httr::content(raw, "text")
  converted <- jsonlite::fromJSON(data, flatten = TRUE)
  return(converted)
}

#' Perform call and maintain JSON Lite structure
#'
#' @param url URL following structure from EPA API
#'
#' @return Results of data request in JSON format
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' call <- create.base.call(endpoint)
#' raw.call <- place.call.raw(call)
#' raw.call
#' }
place.call.raw <- function(url) {
  result <- httr::GET(url)
  return(result)
}


#' Cached version of the perform.call function
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the EPA API endpoint. 
#'@param cache_directory Place inside user-level cache directory to store the cached data. Default: "~/epair/cache".
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' result <- perform.call.cached(endpoint)
#' }

perform.call.cached <- function(endpoint = endpoint, variables = variable.list, directory = "~/epair/cache"){
    if(file.exists(directory) == FALSE){
        dir.create(directory)
    }
    key = list(endpoint,variables)
    new.path = paste(directory, "/", key[[2]][1]$state, key[[2]][2]$bdate, key[[2]][3]$edate, key[[2]][4]$param, sep = "") 
    my.data = R.cache::loadCache(key, pathname = new.path)
    if(is.null(my.data) == TRUE){
        my.data = perform.call(endpoint = endpoint, variables = variable.list)
        R.cache::saveCache(my.data, key=key, pathname = new.path, comment="param")
        my.data
    }
    else{
        my.data  
    }
}


#' Removes memory of cached perform.call for specific parameters
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the EPA API endpoint. 
#' @param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return TRUE if data was successfully forgotten, error message if cached data was not found
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' clear.cache(endpoint)
#' }

clear.cached <- function(endpoint = endpoint, variables = variable.list, directory = "~/epair/cache"){
    key = list(endpoint,variables)
    new.path = paste(directory, "/", key[[2]][1]$state, key[[2]][2]$bdate, key[[2]][3]$edate, key[[2]][4]$param, sep = "") 
    if(file.exists(new.path) == FALSE){
        return("Error: Cached data not found for parameters.")
    }
    else{
        file.remove(new.path)
        print("Done")
    }
}


#' Removes all cached memory of perform.call
#'
#'@param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return 'Done' if data was successfully forgotten, error message if cache directory was not found
#' @export
#'
#' @examples
#' \dontrun{
#' clear.all.data() 
#' }

clear.all.cached <- function(directory = "~/epair/cache"){
    if(file.exists(directory) == FALSE){
        print("Cache directory not found.")
    }
    else{
        unlink(directory, recursive = TRUE)
        print("Done")
    }
}

#' Shows contents of cache directory
#'
#'@param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return Vector of file names currently in cache directory
#' @export
#'
#' @examples 
#' \dontrun{
#' my.files <- cache.data()
#' my.files 
#' }


cached.data <- function(directory = "~/epair/cache"){
    files = list.files(path = directory)
    if(identical(files,character(0))){
        return("No files found in directory or directory not found.")
    }
    else{
        file.list = c()
        for(i in files){
            file.list = c(file.list,i)
        }
        return(file.list)
    }
    
}
