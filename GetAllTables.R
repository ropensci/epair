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


### Experimental case for a single table
sample.table <- list.tbls[[15]]
tbl.list <- populate.service.list( sample.table )
tbl.list$Filter$`By County`$Endpoint

## Perform for all tables (assuming each has a service)
services <- populate.all.services( list.tbls )
services$List$Filter$`Sites by County`

### Get only the endpoints
endpoints <- show.endpoints( list.tbls )
endpoints
