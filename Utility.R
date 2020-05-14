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