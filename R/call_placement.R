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
  endpoint <-  "metaData/isAvailable"
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
#' result <- non.cached.perform.call(endpoint)
#' }
non.cached.perform.call <- function(endpoint, variables = list()) {
  
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
#' @param cache_directory Place inside user-level cache directory to store the cached data. Default: "~/epair/cache".
#' @param cached TRUE or FALSE specifying if the data from the call is to be cached. Default: TRUE.
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' result <- perform.call(endpoint)
#' }
perform.call <- function(endpoint, variables = list(), directory = "~/epair/cache", cached = TRUE) {
    
    if(cached == FALSE) {
        non.cached.perform.call(endpoint, variables)
    }
    else {
        user.path <- paste(directory, "/", paste(unlist(variables), collapse = "_"), sep = "")
        if(file.exists(directory)) {
            if(file.exists(user.path)) {
                retrieve.cached.call(endpoint, variables, user.path)
            }
            else {
                save.new.cached.call(endpoint, variables, user.path)
            }
        }
        else {
            dir.create(directory)
            save.new.cached.call(endpoint, variables, user.path)
        }
    }
}

#' Removes memory of cached perform.call data for specific parameters
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
clear.cached <- function(endpoint, variables = list(), directory = "~/epair/cache") {
    
    user.path <- paste(directory, "/", paste(unlist(variables), collapse = "_"), sep = "")
    
    if(file.exists(user.path) == FALSE) {
        stop("Cached data not found for parameters.")
    }
    else {
        file.remove(user.path)
        return("Done")
    }
}

#' Removes all cached memory of perform.call
#'
#' @param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return 'Done' if data was successfully forgotten, error message if cache directory was not found
#' @export
#'
#' @examples
#' \dontrun{
#' clear.all.data() 
#' }
clear.all.cached <- function(directory = "~/epair/cache") {
    if(file.exists(directory) == FALSE) {
        stop("Cache directory not found.")
    }
    else{
        unlink(directory, recursive = TRUE)
        return("Done")
    }
}

#' Shows contents of cache directory
#'
#' @param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return Character vector of file names currently in cache directory.
#' @export
#'
#' @examples 
#' \dontrun{
#' my.files <- list.cached.data()
#' my.files 
#' }
list.cached.data <- function(directory = "~/epair/cache") {
    
    user.files <- list.files(path = directory)
    
    if(identical(user.files, character(0)) == FALSE) {
        return(user.files)
    }
    else {
        stop("No files found in directory or directory not found.")
    }
}

#' Saves a new call that has not been previously cached yet.
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the EPA API endpoint. 
#' @param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' save.new.cached.call(endpoint)
#' }
save.new.cached.call <- function(endpoint, variables = list(), user.path) {
    user.data <- non.cached.perform.call(endpoint, variables)
    R.cache::saveCache(user.data, pathname = user.path)
    return(user.data)
}

#' Retrieves memory of previously cached call.
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the EPA API endpoint. 
#' @param directory Place inside user-level cache directory that was used to store the cached data previously. Default: "~/epair/cache".
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' retrieve.cached.call(endpoint)
#' }
retrieve.cached.call <- function(endpoint, variables = list(), user.path) {
    user.data <- R.cache::loadCache(pathname = user.path)
    return(user.data) 
}
