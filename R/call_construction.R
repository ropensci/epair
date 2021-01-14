#' Generate the string authentication needed for EPA API
#'
#' @param email Email registered with EPA API
#' @param key Key obtained from EPA API. Register your email for a key here https://aqs.epa.gov/aqsweb/documents/data_api.html#signup.
#'
#' @return A string with authentication info. It looks like '&email=user_email&key=user_key'.
#' @export
#'
#' @examples
#' auth <- create.authentication("myemail@domain.com", "myapikey")
#' auth
create.authentication <- function(email, key) {
  authentication.string <- sprintf("&email=%s&key=%s", email, key)
  return(authentication.string)
}

#' Make the first call when forming a query.
#'
#' @param endpoint Endpoint for forming a query. See ENDPOINTS for all available endpoints. See 
#' SERVICES if you know the service but not the endpoint.
#'
#' @return A URL string containing authentication for the call.
#'
#' @examples
#' \dontrun{
#' endpoint <- "list/states"
#' call <- epair:::create.base.call(endpoint)
#' call
#' }
create.base.call <- function(endpoint) {
  if (length(getOption("epa_authentication")) == 0) {
    stop("Make sure you've declared the option for epa_authentication.")
  }
  base <- "https://aqs.epa.gov/data/api/"
  result <- paste(base, endpoint, "?", getOption("epa_authentication"), sep = "")
  return(result)
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
#' \dontrun{
#' endpoint <- 'dailyData/byState'
#' state <- "37"
#' call <- epair:::create.base.call(endpoint)
#' call <- add.variable(call, state)
#' call     # Call requires more variables before being placed
#' }
add.variable <- function(query, variable, name = deparse(substitute(variable))) {
  var.name <- name
  variable <- gsub(" ", "%20", fixed = TRUE, variable)
  result <- paste(query, "&", var.name, "=", variable, sep = "")
  return(result)
}

#' Add variables to a query
#'
#' @param query A URL containing authentication for the EPA API site.
#' @param variables A list of variables. Each variable should be declared with the appropriate name.
#' Consult VARIABLE.TYPES for the right names.
#' @param name A list containing names of API variables.
#'
#' @return A URL consisting of query + variables.
#' @export
#'
#' @examples
#' \dontrun{
#' endpoint <- "dailyData/byState"
#' variable.list <- list("state" = '37', 
#'                       "bdate" = '20200101', 
#'                       "edate" = '20200102', 
#'                       "param" = '44201')
#' call <- epair:::create.base.call(endpoint)
#' call <- add.variables(call, variable.list)
#' call
#' }
add.variables <- function(query, variables, name = NA) {
  # A list of names for API variables was not passed,
  # extract names from variables
  if(is.na(name)) {
    var.names <- names(variables)
    for (i in seq_along(variables)) {
      var.name <- var.names[i]
      variable <- gsub(" ", "%20", fixed = TRUE, variables[[var.name]])
      query <- paste(query, "&", var.name, "=", variable, sep = "")
    }
  }
  # A list of names for API variables got passed,
  # extract names from list that got passed
  else {
    var.names <- name
    for (i in seq_along(variables)) {
      var.name <- var.names[i]
      variable <- gsub(" ", "%20", fixed = TRUE, variables[i])
      query <- paste(query, "&", var.name, "=", variable, sep = "")
    }
  }
  
  return(query)
}