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
#' endpoint <- "list/states"
#' call <- epair:::create.base.call(endpoint)
#' call
create.base.call <- function(endpoint) {
  if (!nzchar(Sys.getenv('aqs_api_key'))) {
    stop("Make sure you've declared aqs_api_key in your .Renviron!")
  }
  if (!nzchar(Sys.getenv('aqs_email'))) {
    stop("Make sure you've declared aqs_email in your .Renviron!")
  }
  authentication = create.authentication(Sys.getenv("aqs_email"), Sys.getenv("aqs_api_key"))
  base <- "https://aqs.epa.gov/data/api/"
  result <- paste(base, endpoint, "?", authentication, sep = "")
  return(result)
}

#' Add variables to a query
#'
#' @param query A URL containing authentication for the EPA API site.
#' @param variables A list of variables. Each variable should be declared with the appropriate name.
#' Consult VARIABLE.TYPES for the right names.
#'
#' @return A URL consisting of query + variables.
#' @export
#'
#' @examples
#' endpoint <- "dailyData/byState"
#' variable.list <- list("state" = '37', 
#'                       "bdate" = '20200101', 
#'                       "edate" = '20200102', 
#'                       "param" = '44201')
#' call <- epair:::create.base.call(endpoint)
#' call <- add.variables(call, variable.list)
#' call
add.variables <- function(query, variables) {
    var.names <- names(variables)
    for (i in seq_along(variables)) {
      var.name <- var.names[i]
      variable <- gsub(" ", "%20", fixed = TRUE, variables[[var.name]])
      query <- paste(query, "&", var.name, "=", variable, sep = "")
    }
    return(query)
}
