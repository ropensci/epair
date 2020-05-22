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
###

### Experimental case
sample.table <- list.tbls[[15]]
copy.table <- sample.table

#### Recopy filter entries to cover the service entry
copy.table <- correct.overflow.filter( sample.table )

copy.table$Filter
sample.table$Filter

#### Create (possible reordering of code blocks here) sample list structure 
#### Will contain final product

sample.list <- list()

# Set up service name
sample.list$Service <- copy.table$Service[1]
sample.list
####

#### Test procedure
sample.list$Filter <- create.filter.list( copy.table )
sample.list$Filter



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


