#' Get an API key from the AQS API. 
#'  
#' @param user.email Email provided by the user to get an API key for.
#' @export
#' @examples
#' \dontrun{
#' email <- "an.example.email@domain.com"
#' get_aqs_key(email)
#' }
get_aqs_key <- function(user.email) {
  url.for.call <- paste0("https://aqs.epa.gov/data/api/signup?email=",
                         user.email)
  raw <- httr::GET(url.for.call)
  message(raw)
}


#' Check if the API is up and running 
#'
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' is_API_running()
#' }
is_API_running <- function() {
  endpoint <-  "metaData/isAvailable"
  url <- create.base.call(endpoint)
  raw <- httr::GET(url)
  text.content <- httr::content(raw, "text")
  converted <- jsonlite::fromJSON(text.content, flatten = TRUE)
  message(converted$Header$status)
  message(converted$Header$request_time)
  
  is.up <- 200 == raw$status_code
  return(is.up)
}

#' Perform call and keep original result
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter
#' the EPA API endpoint. 
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
#' @param variables A list of variables or a single variable to filter the
#' EPA API endpoint. 
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
#' @param variables A list of variables or a single variable to filter 
#' the EPA API endpoint. 
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache".
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE.
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' result <- perform.call(endpoint)
#' }
perform.call <- function(endpoint, variables = list(),
                         cached = TRUE,
                         cache_directory = "/cache") {
    full.directory <- ifelse(cache_directory == "/cache", 
                             paste(getwd(),cache_directory, sep = ""), 
                             cache_directory)
    if(cached == FALSE) {
        return(non.cached.perform.call(endpoint, variables))
    }
    else {
        if(file.exists(full.directory)) {
            user.path <- paste(full.directory,
                               "/",
                               stringr::str_remove_all(endpoint, "/"),
                               paste(unlist(variables),
                                     collapse = "_"),
                               sep = "")
            if(file.exists(user.path)) {
                return(retrieve.cached.call(endpoint,
                                            variables,
                                            full.directory))
            }
            else {
                return(save.new.cached.call(endpoint,
                                            variables,
                                            full.directory))
            }
        }
        else {
            dir.create(full.directory)
            return(save.new.cached.call(endpoint,
                                        variables,
                                        full.directory))
        }
    }
}

#' Removes memory of cached perform.call data for specific parameters
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter the 
#' EPA API endpoint. 
#' @param directory Place inside user-level cache directory that was used to 
#' store the cached data previously. Default: "/cache".
#'
#' @return TRUE if data was successfully forgotten, error message if cached 
#' data was not found
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' clear.cached(endpoint)
#' }
clear.cached <- function(endpoint,
                         variables = list(), 
                         directory = "/cache") {
    full.directory <- ifelse(directory == "/cache", 
                             paste(getwd(),directory, sep = ""), 
                             directory)
    user.path <- paste(full.directory,
                       "/", 
                       stringr::str_remove_all(endpoint, "/"),
                       paste(unlist(variables), collapse = "_"), 
                       sep = "")
    
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
#' @param directory Place inside user-level cache directory that was used
#' to store the cached data previously. Default: "/cache".
#'
#' @return 'Done' if data was successfully forgotten, error message if 
#' cache directory was not found
#' @export
#'
#' @examples
#' \dontrun{
#' clear.all.cached() 
#' }
clear.all.cached <- function(directory = "/cache") {
    full.directory <- ifelse(directory == "/cache",
                             paste(getwd(),directory, sep = ""),
                             directory)
    if(file.exists(full.directory) == FALSE) {
        stop("Cache directory not found.")
    }
    else{
        unlink(full.directory, recursive = TRUE)
        return("Done")
    }
}

#' Shows contents of cache directory
#'
#' @param directory Place inside user-level cache directory that was used to 
#' store the cached data previously. Default: "/cache".
#'
#' @return Character vector of file names currently in cache directory.
#' @export
#'
#' @examples
#' \dontrun{ 
#' my.files <- list.cached.data()
#' my.files 
#' }
list.cached.data <- function(directory = "/cache") {
    full.directory <- ifelse(directory == "/cache",
                             paste(getwd(),directory, sep = ""),
                             directory)
    user.files <- list.files(path = full.directory)
    
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
#' @param variables A list of variables or a single variable to filter 
#' the EPA API endpoint. 
#' @param directory Place inside user-level cache directory that was used 
#' to store the cached data previously. Default: "/cache".
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- 'list/states'
#' save.new.cached.call(endpoint)
#' }
save.new.cached.call <- function(endpoint,
                                 variables = list(),
                                 directory = "/cache") {
    full.directory <- ifelse(directory == "/cache",
                             paste(getwd(),directory, sep = ""),
                             directory)

    user.path <- paste(full.directory,
                       "/",
                       stringr::str_remove_all(endpoint, "/"), 
                       paste(unlist(variables), collapse = "_"),
                       sep = "")
    
    user.data <- non.cached.perform.call(endpoint, variables)
    R.cache::saveCache(user.data, pathname = user.path)
    return(user.data)
}

#' Retrieves memory of previously cached call.
#'
#' @param endpoint An endpoint from the available EPA API endpoints
#' @param variables A list of variables or a single variable to filter
#' the EPA API endpoint. 
#' @param directory Place inside user-level cache directory that was used
#' to store the cached data previously. Default: "/cache".
#'
#' @return A list containing requested data
#' @export
#'
#' @examples
#' endpoint <- 'list/states'
#' retrieve.cached.call(endpoint)
retrieve.cached.call <- function(endpoint,
                                 variables = list(),
                                 directory = "/cache") {
    full.directory <- ifelse(directory == "/cache",
                             paste(getwd(),directory, sep = ""),
                             directory)
    user.path <- paste(full.directory,
                       "/",
                       stringr::str_remove_all(endpoint, "/"),
                       paste(unlist(variables), collapse = "_"),
                       sep = "")
    user.data <- R.cache::loadCache(pathname = user.path)
    return(user.data) 
}
