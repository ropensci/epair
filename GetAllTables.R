# Acquire all endpoints in API

library(rvest)

# if (j+k > nrow(out)) break;
# Should go into xml_node to actually work.

fixInNamespace("html_table.xml_node", "rvest")

site <- read_html( 'https://aqs.epa.gov/aqsweb/documents/data_api.html' )
tbls <- html_nodes( site, "table" )
tbls

df.tbls <- html_table(tbls, fill = TRUE)

"Service" %in% colnames(df.tbls[[1]])

df.tbls[[5]]$Endpoint

# Make endpoints 

endpoints <- c()
for( i in 1:length( df.tbls ) ){
  if( "Endpoint" %in% colnames( df.tbls[[i]] ) ){
   endpoints <- c( endpoints, df.tbls[[i]]$Endpoint[1] ) 
  }
}
endpoints



