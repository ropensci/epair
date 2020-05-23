# Find a way to include service descriptions for each service. 

library(rvest)
source("Utility.R")

# if (j+k > nrow(out)) break;
# Should go into xml_node to actually work.
fixInNamespace("html_table.xml_node", "rvest")


# Create new description variable for each service by using old services table
get.service.names()
names.services <- show.service.names()
tbls <- get.all.tables()
my.services <- populate.all.services( tbls )

single.name <- names.services[3]
single.name

my.services[[ single.name ]]$Description <- SERVICE.NAMES[[ single.name ]][2]

### Make special case for second list
give.description <- function( services, service.name){
  # Second entry in vector is description
  services[[ service.name ]]$Description <- SERVICE.NAMES[[ service.name ]][2]
  return( services )
}   


give.description( my.services, single.name )

service.names <- show.service.names()
for( service.name in service.names){
  my.services <- give.description( my.services, service.name)
}
my.services

# Assign description to services in list structure
get.services <- function(){
  if( length( SERVICE.NAMES)  == 0){
    stop( "Must populate SERVICE.NAMES with names and descriptions of service.")
  }
  tbls <- get.all.tables()
  services <- populate.all.services( tbls )
  return( services )
}

