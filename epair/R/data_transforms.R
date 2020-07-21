#### This module was built to hold data transformations on scraped tables from the EPA API

#' Take a list of html tables from api and output all endpoints
#'
#' @param list.tables List of HTML tables from EPA API
#'
#' @return Vector with only endpoints for the API.
#' @export
#'
#' @examples
#' API.tables <- get.all.tables()
#' endpoints <- find.endpoints.in.tables( API.tables )
#' endpoints
find.endpoints.in.tables <- function( list.tables ){
  endpoints <- c()
  for( i in 1:length( list.tables ) ){
    if( "Endpoint" %in% colnames( list.tables[[i]] ) ){
      endpoints <- c( endpoints, list.tables[[i]]$Endpoint ) 
    }
  }
  # Don't insert entries that aren't endpoints
  pure.endpoints <- c()
  for( i in 1:length( endpoints ) ){
    if( !endpoint.checker( endpoints[i] ) ){
      pure.endpoints <- c( pure.endpoints, endpoints[i])
    }
  }
  return( pure.endpoints )
}

#' Show endpoint for listing information on a variable
#'
#' @param variable.type A variable used in the EPA API service. Consult VARIABLE.TYPES for available variables.
#' @param variable.types A list contianing variable types mapped to their endpoints. This vector 
#' should be loaded in with the package and can be found in the package data files. Type ?variable.types
#' for more info.
#' 
#' @return An endpoint character that lists information to help the user query a variable.
#' @export
#'
#' @examples
#' get.list.variable.endpoint( "state" )
#' get.list.variable.endpoint( "classes" )
get.list.variable.endpoint <- function( variable.type, variable.types ){
  name <- substitute( variable.type ) 
  return( variable.types[[name]] )
}

#' Check if a string contains characters not seen in endpoints
#'
#' @param string A character entry from entries in the data frame of API services
#'
#' @return A boolean reflecting presence of endpoint in string
#' @export
#'
#' @examples
#' endpoint.checker( "list/states" )
#' endpoint.checker( "https://example here")
endpoint.checker <- function( string ){
  example.check <- grepl( "Example", string, fixed = TRUE)
  returns.check <- grepl( "Returns", string, fixed = TRUE)
  https.check <- grepl( "https:", string, fixed = TRUE)
  return( example.check | returns.check | https.check)
}

#' Replace all characters entries in df
#'
#' @param df Data frame containing character entries
#' @param pattern Pattern to use for matching
#' @param replacement Replacement of entries matching pattern
#'
#' @return A data frame with entries following the pattern being replaced by replacement
#' @export
#'
#' @examples
#' df <- data.frame( c("1", "2", "3", "4"))
#' modified.df <- string.replacer( df, "1", "One")
#' modified.df
string.replacer <- function( df, pattern, replacement){
  modified.df <- lapply( df, gsub, pattern = pattern, replacement = replacement, fixed = TRUE)
  return( as.data.frame( modified.df ) )
}

#' Replace every string entry in a list 
#'
#' @param entry.list List containing character entries
#' @param pattern Pattern to replace
#' @param replacement Replacement for entries following the pattern
#'
#' @return A list with entries matching the pattern replaced by replacement
#' @export
#'
#' @examples
#' services <- get.services()
#' services <- list.string.replacer( services, "\t", "")
#' services
list.string.replacer <- function( entry.list, pattern, replacement ){
  new.list <- rapply( entry.list, 
                      gsub, 
                      pattern = pattern, 
                      replacement = replacement, 
                      fixed = TRUE,
                      how = "replace")
  return( new.list )
}

#' Remove '\t', '\r\n', "   " from entries in a data frame
#'
#' @param df Data frame to remove '\t', '\r\n', "   " from
#'
#' @return Data frame without '\t', '\r\n', "   "
#' @export
#'
#' @examples
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- get.table( url, table.path )
#' df
#' 
#' clean.df <- remove.escapes.spaces( df )
#' clean.df
remove.escapes.spaces <- function( df ){
  clean.df <- string.replacer( df, "\t", "") %>%
    string.replacer( "\r\n", "") %>%
    string.replacer( "   ", "")
  return( clean.df )
}

#' Remove '\t', '\r\n', "   " from entries in a list
#'
#' @param a.list List to remove entries from.
#'
#' @return A list without '\t', '\r\n' and "  "
#' @export
#'
#' @examples
#' services <- get.services()
#' services <- list.remove.escapes.spaces( services )
#' services
list.remove.escapes.spaces <- function( a.list ){
  new.list <- list.string.replacer( a.list, "\t", "") %>%
    list.string.replacer( "\r\n", "") %>%
    list.string.replacer( "   ", "")
  return( new.list )
}

#' Transpose a data frame
#'
#' @param df Data frame to be transposed
#'
#' @return The transposed data frame. First variable entries become column names.
#' @export
#'
#' @examples
#' url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
#' table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
#' df <- get.table( url, table.path )
#' t.df <- get.transpose( df )
#' t.df
get.transpose <- function( df  ){
  t.df <-  t( df )
  t.names <- c()
  for( i in 1:nrow( df ) ){
    t.names <- c( t.names, df[i, 1] )
  }
  colnames( t.df ) <- t.names
  return( as.data.frame(t.df, stringsAsFactors = FALSE) )
}



