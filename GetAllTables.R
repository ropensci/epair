# Acquire all endpoints in API

library(rvest)
source("Utility.R")

# if (j+k > nrow(out)) break;
# Should go into xml_node to actually work.
fixInNamespace("html_table.xml_node", "rvest")

### Getting all tables on the API
site <- read_html( 'https://aqs.epa.gov/aqsweb/documents/data_api.html' )
tbls <- html_nodes( site, "table" )
list.tbls <- html_table(tbls, fill = TRUE)


sample.table <- list.tbls[[15]]
sample.table$`Required Variables`

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


