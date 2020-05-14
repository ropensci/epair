# Get html data for API how to site https://aqs.epa.gov/aqsweb/documents/data_api.html

library(XML)

doc.html = htmlTreeParse('https://aqs.epa.gov/aqsweb/documents/data_api',
                         useInternal = TRUE)

library(rvest)
url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
raw.html.doc <- html( url )
raw.html.doc
class(raw.html.doc)

table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'

node <- html_nodes( raw.html.doc, xpath = table.path )

the.table <- html_table( node )

class(the.table[[1]])

head(the.table[[1]])

final.table <- the.table[[1]]

summary(final.table)
final.table[1,1]
final.table[1,]

final.table[3,]
class(final.table[3,2])

> foo <- vector(mode="list", length=3)
> names(foo) <- c("tic", "tac", "toe")
> foo[[1]] <- 12; foo[[2]] <- 22; foo[[3]] <- 33

table.list <- vector( mode = "list", length = nrow( final.table) )
names( table.list ) <- as.vector( final.table[1])
table.list

names.vector <- c()
for( i in 1:nrow( final.table ) ){ 
  names.vector <- c( names.vector, final.table[i,1])
}
names.vector

names( table.list ) <- names.vector
table.list

t(final.table)
