# Revamp, rewrite, innovate a method for populating tables

tbls <- get.all.tables()

tbls[[5]]$Endpoint

## Solution using hard coded table structure

# Split into tables having multiple examples and those having only one
# --> Anyone before the 4th is unnecessary
# - Meta data is the only table having the third-ish entry down as multiple
tables.to.modify <- list( tbls[[4]],
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

# -- service.list -> final structure containing all services and their info
service.list <- list()

#' Give a service name
#'
#' @param df 
#' @param service.list 
#'
#' @return Service 
#'
#' @examples
assign.service.name <- function( df, service.list ){
  service.name <- df$Service[1]
  service.list[[service.name]] <- "Place Holder"
  return( service.list )
}
service.list <- assign.service.name( single, service.list)

#' Title
#'
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
get.true.filters <- function( df ){
  unique.filters <- unique( df$Filter )
  unique.filters <- unique.filters[which( unique.filters != service.name )]
  return( unique.filters )
}
true.filters <- get.true.filters( single )

#' Title
#'
#' @param filter.name 
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
get.first.entry.for.filter <- function( filter.name, df ){
  indices <- which( df$Filter == filter.name)
  first.occurence <- min( indices )
  return( first.occurence )
}
first.occurence.of.rh <- get.first.entry.for.filter( "Revision History", single)

# Get the first occurence for each member of true filters
#' Title
#'
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
get.first.occurences <- function( df ){
  true.filters <- get.true.filters( df )
  first.occurences <- sapply( true.filters, find.first.entry.for.filter, df)
  return( first.occurences )
}
first.occurences <- get.first.occurences( single )

# Holds indices of first occurence of a filter
# -- hypothesizing they fit in properly
first.indices.for.filters 





######

# Then take the min
single$Filter

single$Filters 

single$Endpoint

single$`Required Variables`

single$`Optional Variables`
