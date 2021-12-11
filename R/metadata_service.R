source("R/endpoints.R")

#' Get the API's revision history. 
#'  
#' @export
#' @examples
#' \dontrun{
#' result <- get_revision_history()
#' result$Data
#' }
get_revision_history <- function(){
  full.endpoint <- paste(META_DATA, REVISION_HISTORY, sep = "/")
  result <- perform.call(full.endpoint)
  return(result)
}

#' Get any known issues within the API.
#'
#' @export
#' \dontrun{
#' result <- get_known_issues()
#' result$Data
#' }
get_known_issues <- function(){
  full.endpoint <- paste(META_DATA, ISSUES, sep = "/")
  result <- perform.call(full.endpoint)
  return(result)
}

#' Get fields required per service.
#' 
#' @param service A service provided by EPA's AQS system.
#' 
#' @export
#' \dontrun{
#' result <- get_fields_by_service()
#' result$Data
#' }
get_fields_by_service <- function(service){
  full.endpoint <- paste(META_DATA, FIELDS_BY_SERVICE, sep = "/")
  result <- perform.call(full.endpoint, variables = list("service" = service))
  return(result)
}
