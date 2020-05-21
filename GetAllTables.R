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

copy.table <- sample.table
####

for( i in 1:length( sample.table$Filter) ){
  if( sample.table$Filter[i] == sample.table$Service[1]){
    copy.table$Filter[i] <- sample.table$Filter[i - 1] # Assign the previous entry, still in same filter
  }
}

copy.table$Filter

sample.table$Filter

#### Filter complete 

sample.list <- list()

# Set up service name
sample.list$Service <- copy.table$Service[1]
sample.list

####
i = 0
while( i < 3){
  print(i)
  i <- i + 1
}

example.check <- function( string ){
  return( grepl("Example", string, fixed = TRUE) )
}

sample.table$`Required Variables`

sample.table$`Optional Variables`
T & T

sample.table$Filter[which(sample.table$Filter == "By Site")]

for(i in 1:2){
  print(i)
}

# Contain my lists of lists here 
count(sample.table$Filter)
#### Now, how to do it for each 
unique(sample.table$Filter)
table(sample.table$Filter)

counts <- table(copy.table$Filter)
names(counts)
counts[["By County"]]

filter.list[["my"]] <- 0

names.count <- names(counts)
filter.list <- list()
for(i in 1:length( names.count  )){
  filter.name <- names.count[i]
  count <- counts[[filter.name]]
  row.numbers <- determine.filter( filter.name )
  results.list <- list()
  for( element in row.numbers){
    results.list <- append( results.list, create.list.endpoints.examples.params( element, copy.table ) )
  }
  filter.list[[filter.name]] <- results.list
}
filter.list$`By County`$Endpoint
filter.list$`By County`$RequiredVariables
filter.list$`By County`$Example

class(filter.list$`By Monitoring Agency`)

for(element in v){
  print(element)
}

determine.filter <- function( name.filter ){
  indices <- which(copy.table$Filter == name.filter)
  return( indices )
}

determine.filter( "By County")

# Find where a place starts
copy.table$Filter[which(copy.table$Filter == "By Site")]
which(copy.table$Filter == "By County")

create.list.endpoints.examples.params <- function( row.number, df ){
  test.list <- list()
  if( ! example.check( df$Endpoint[row.number]) ){
      # Add the endpoint to the endpoint reading
      test.list$Endpoint <- df$Endpoint[row.number]
  }
  if( ! example.check( df$'Required Variables'[row.number]) ){
      test.list$RequiredVariables <- df$'Required Variables'[row.number]
  }
  if( ! example.check( df$`Optional Variables`[row.number]) & df$'Optional Variables'[row.number] != ""){
      # Add the param variables there
      test.list$OptionalVariables <- df$`Optional Variables`[row.number]
  }
  if( example.check( df$Endpoint[row.number]  ) ){
    test.list$Example <- df$Endpoint[row.number] # Should be an example
  }
 test.list
 return( test.list )
}
result.list <- create.list.endpoints.examples.params( 8, copy.table)
result.list
####

# Test case for creating a list with the first friends here...
create.list.endpoints.examples.params <- function( number.counts ){
  test.list <- list()
  for(i in 1:number.counts ){
    if( ! example.check( sample.table$Endpoint[i]) ){
      # Add the endpoint to the endpoint reading
      test.list$Endpoint <- sample.table$Endpoint[i]
    }
    if( ! example.check( sample.table$'Required Variables'[i]) ){
      test.list$RequiredVariables <- sample.table$'Required Variables'[i]
    }
    if( ! example.check( sample.table$`Optional Variables`[i]) & sample.table$'Optional Variables'[i] != ""){
      # Add the param variables there
      test.list$OptionalVariables <- sample.table$`Optional Variables`
    }
  }
  test.list
  return( test.list )
}
test.list <- list()
for(i in 1:2 ){
  if( ! example.check( sample.table$Endpoint[i]) ){
    # Add the endpoint to the endpoint reading
    test.list$Endpoint <- sample.table$Endpoint[i]
  }
  if( ! example.check( sample.table$'Required Variables'[i]) ){
    test.list$RequiredVariables <- sample.table$'Required Variables'[i]
  }
  if( ! example.check( sample.table$`Optional Variables`[i]) & sample.table$'Optional Variables'[i] != ""){
    # Add the param variables there
    test.list$OptionalVariables <- sample.table$`Optional Variables`
  }
}
test.list
####


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


