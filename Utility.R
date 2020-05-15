## Utility package for creating queries in EPA API 
# at https://aqs.epa.gov/aqsweb/documents/data_api.html#signup

create_authentication <- function( email, password ){
  authentication <- sprintf('email=%s&key=%s', email, password)
  return( authentication )
}

create_base_query <- function( endpoint ){
  # Assuming base doesn't change for a near future. 
  base = 'https://aqs.epa.gov/data/api/'
  query = paste( base, endpoint, "?", sep = '' )
  return(query)
}

query <- function( base_query, authentication  ){
  call <- paste( base_query, authentication, sep = '' )
  return( call )
}

# Output a data frame containing a table using url and xpath to the table 
get.table <- function( url, table.xpath ){
  found.table <- url %>%
    read_html() %>%
    html_nodes( xpath = table.xpath ) %>% 
    html_table()
  return( found.table[[1]] )
}

# Remove \r \n \t from entries
# TODO, simplify code with multiple pattern regex matching
remove.escapes <- function( df ){
  for(i in 1:nrow(df) ){
    for(j in 1:ncol(df) ){
      df[i, j] <- gsub( "\n", "", df[i, j] )
      df[i, j] <- gsub( "\r", "", df[i, j] )
      df[i, j] <- gsub( "\t", "", df[i, j] )
    }
  }
  return( df )
}

# Get the transpose of a df, and turn the first column into the names of the 
# df
get.transpose <- function( df  ){
  t.df <-  t(df)
  t.names <- c()
  for( i in 1:nrow(df)){
    t.names <- c(t.names, df[i, 1])
  }
  colnames(t.df) <- t.names
  return( as.data.frame(t.df) )
}

# Get table showing list of services
get.table.services <- function(){
  
  url <- "https://aqs.epa.gov/aqsweb/documents/data_api.html"
  table.path <- '//*[@id="main-content"]/div[2]/div[1]/div/div/table[1]'
  df <- get.table( url, table.path )
  
  # TODO extra spaces, some words got squished
  df <- remove.escapes( df )
  
  new.df <- get.transpose(df)
  
  return( new.df )
}
# Print services provided by the API and get df containing services and descriptions.
## TODO speed up response by setting a constant value
get.services <- function(){
  services.table <- get.table.services()
  print( colnames(services.table) )
  return( services.table )
}