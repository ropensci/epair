# Revamp, rewrite, innovate a method for populating tables

tbls <- get.all.tables()

tbls[[5]]$Endpoint

## Solution using hard coded table structure

# Split into tables having multiple examples and those having only one
# --> Anyone before the 4th is unnecessary
# - Meta data is the only table having the third-ish entry down as multiple
tables.to.modify <- list( tbls[[4]],tbls[[5]],
                                 tbls[[6]],
                                 tbls[[7]],
                                 tbls[[8]],
                                 tbls[[9]],
                                 tbls[[10]], 
                                 tbls[[11]], 
                                 tbls[[12]],
                                 tbls[[13]],
                                 tbls[[14]],
                                 tbls[[15]])

## Iterating through, apply to all members

# Prototype the list
single <- tbls[[4]]

#' Get filter names in data frame
#'
#' @param df Data frame containing repeated or mixed filter names.
#'
#' @return Vector containing only filter names for the API service. Service name 
#' and repeated filter names are removed. 
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[6]]
#' get.true.filters( single )
get.true.filters <- function( df ){
  service.name <- df$Service[1]
  unique.filters <- unique( df$Filter )
  unique.filters <- unique.filters[which( unique.filters != service.name )]
  return( unique.filters )
}
true.filters <- get.true.filters( single )


first.occurence.of.rh <- get.first.entry.for.filter( "Revision History", single)


#' Get first entries for filter names
#'
#' @param df Data frame with filters
#'
#' @return A vector of indices. These indices are where the first entry for a filter 
#' exists in df. 
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[10]]
#' first.occurences <- get.first.occurences( single )
get.first.occurences <- function( df ){
  true.filters <- get.true.filters( df )
  first.occurences <- sapply( true.filters, find.first.entry.for.filter, df)
  return( first.occurences )
}
first.occurences <- get.first.occurences( single )

# Possible to extract something here...

names(first.occurences)[1]
# "Is the API available for use?"

#' Generate filter content for an API filter
#'
#' @param i Row number at which to get the information for filter.
#' @param df The data frame containing filter information.
#'
#' @return A list with filter content (endpoint, required variables, etc.)
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[7]]
#' content <- generate.filter.content( 1, single )
generate.filter.content <- function( i, df){
  filter.content <- list( Endpoint = df$Endpoint[i],
                          RequiredVariables = df$`Required Variables`[i],
                          OptionalVariables = df$`Optional Variables`[i],
                          Example = df$Endpoint[i + 1])
  return( filter.content )
}
rev.his <- generate.filter.content( 3, single)

#' Create a single filter 
#'
#' @param filter.name Name of filter in API service
#' @param i Row number to use to create filter. Make sure filter information is 
#' present at i before hand.
#' @param df Data frame with filter information.
#'
#' @return A list with filter content given to the filter name.
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[9]]
#' filter.name <- "My filter"
#' setup.single.filter( filter.name, 1, single)
setup.single.filter <- function( filter.name, i, df ){
  filter.content <- generate.filter.content( i, df )
  filter.out <- list()
  filter.out[[filter.name]] <- filter.content
  return( filter.out )
}

# Get each filter in that table named and ready to go 
filters.list <- list()
first.occurences <- get.first.occurences( single )
n = length(first.occurences)
for( i in 1:n){
  filter.name <- names(first.occurences)[i]
  filter.index <- first.occurences[[i]]
  filter.out <- setup.single.filter( filter.name, filter.index, single) # Single to modify for many
  filters.list <- c( filters.list, filter.out)
}
filters.list$`Known Issues`

#' Create a list of filters
#'
#' @param df A data frame having filter information (e.g. name, required variables).
#'
#' @return A list containing filters and respective info. 
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[8]]
#' generate.filters.list( single )
generate.filters.list <- function( df ){
  filters.list <- list()
  first.occurences <- get.first.occurences( df )
  n = length(first.occurences)
  for( i in 1:n){
    filter.name <- names(first.occurences)[i]
    filter.index <- first.occurences[[i]]
    filter.out <- setup.single.filter( filter.name, filter.index, df)
    filters.list <- c( filters.list, filter.out)
  }
  return( filters.list )
}
single.filters <- generate.filters.list( single )

####### Putting it all together

#' Make list of single service
#'
#' @param df Data frame with info to make an API service. 
#'
#' @return A list with the filter content of a service set to the service name.
#' @export
#'
#' @examples
#' tbls <- get.all.tables()
#' single <- tbls[[8]]
#' setup.service( single )
setup.service <- function( df ){
  service.list <- list()
  service.name <- df$Service[1]
  service.list[[service.name]] <- generate.filters.list( df )
  return(service.list)
}
example <- setup.service(single)

# -- service.list -> final structure containing all services and their info
service.list <- list()
for( i in 1:length(tables.to.modify)){
  df <- tables.to.modify[[i]]
  single.service <- setup.service( df )
  service.list <- c( service.list, single.service)
}
service.list$List$`Parameters in a class (obtain the list of classes from the List - Parameter Classes service)`

#' Turn tables of API services into a list
#'
#' @param tables.to.modify List of tables from API. Each table is a data frame.  
#'
#' @return A list with each service and filters as chained variables to make for easy calling.
#' @export
#'
#' @examples
#' tables.to.modify <- get.all.tables()
#' services <- populate.all.services( tables.to.modify )
#' services$List
populate.all.services <- function( tables.to.modify ){
  service.list <- list()
  for( i in 1:length(tables.to.modify)){
    df <- tables.to.modify[[i]]
    single.service <- setup.service( df )
    service.list <- c( service.list, single.service)
  }
  return(service.list)
}
services <- populate.all.services( tables.to.modify )
