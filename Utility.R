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