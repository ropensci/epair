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
  service.name <- df$Service[1]
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

# Possible to extract something here...

names(first.occurences)[1]
# "Is the API available for use?"

#' Title
#'
#' @param i 
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
generate.filter.content <- function( i, df){
  filter.content <- list( Endpoint = df$Endpoint[i],
                          RequiredVariables = df$`Required Variables`[i],
                          OptionalVariables = df$`Optional Variables`[i],
                          Example = df$Endpoint[i + 1])
  return( filter.content )
}
rev.his <- generate.filter.content( 3, single)

#' Title
#'
#' @param filter.name 
#' @param i 
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
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

#' Get filters going
#'
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
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

#' Title
#'
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
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
