# Acquire all endpoints in API
# Get all tables into a list of services

library(rvest)
source("Utility.R")

# if (j+k > nrow(out)) break;
# Should go into xml_node to actually work.
fixInNamespace("html_table.xml_node", "rvest")

### Getting all tables on the API
site <- read_html( 'https://aqs.epa.gov/aqsweb/documents/data_api.html' )
tbls <- html_nodes( site, "table" )
list.tbls <- html_table(tbls, fill = TRUE)
###

class(list.tbls[[1]])


### Experimental case
sample.table <- list.tbls[[15]]
copy.table <- sample.table

# Function testing
tbl.list <- populate.service.list( copy.table )
tbl.list

## Perform for all tables (assuming each has a service)

tbl.list$Service

# Take a list of html tables, output a list of lists, each list a service.
populate.all.services <- function( list.tables ){
  services.list <- list()
  for( i in 1:length( list.tables ) ){
    df <- list.tables[[i]]
    if(  length( df$Filter ) !=0  ) {
      if( !is.na( df$Filter )[1] ) {
        service.name <- df$Service[1]
        services.list[[ service.name ]] <- populate.service.list( df )
      }
    }
  }
  return( services.list )
}

services <- populate.all.services( list.tbls )

services$MetaData$Filter$

is.null(list.tbls[[1]]$Filter)

######## Just endpoints #########
### Find the endpoints
endpoints <- c()
for( i in 1:length( df.tbls ) ){
  if( "Endpoint" %in% colnames( df.tbls[[i]] ) ){
   endpoints <- c( endpoints, df.tbls[[i]]$Endpoint ) 
  }
}
# Filter out entries that aren't endpoints
pure.endpoints <- c()
for( i in 1:length( endpoints ) ){
  if( !endpoint.checker( endpoints[i] ) ){
    pure.endpoints <- c( pure.endpoints, endpoints[i])
  }
}
pure.endpoints
######## Just endpoints #########


