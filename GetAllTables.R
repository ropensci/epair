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








### Create structure, formulate structure for endpoints and querying.
# -> Makes sense for this to be non-rectangular

sample.table$Service[1]

list.data <- list()
# 1 Collapse service 
list.data$Service <- sample.table$Service[1]

# Filter - Endpoint - Example
# -- should be rectangular. or an arrow somehow...

sample.table[3,]

nrow(sample.table)

for( i in 1:nrow( sample.table )){
  print( sample.table[i, 4] )
}


sample.table




















# 2 If an entry matches the service then it doesn't belong. Turn it into an NA. 
# Or remove it. Contain only the filters. 
## -- Thought is the row on left expands into rows on right.
## --> Remove those

# Turn into a list...
list.data$Filter <- sample.table$Filter[which( sample.table$Filter != list.data$Service  )]
list.data$Filter

list.data

# 3 Find wat to match the filter with the proper endpoint

# 4 Divide up the examples to be in a separate node
sample.table$Endpoint

# It seems like optional and required variables need their own filtering mechanism.

sample.table$`Optional Variables`









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


