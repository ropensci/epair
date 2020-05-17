# Functions created to experiment with EPA API.
# No longer in use. 

create_base_query <- function( endpoint ){
  # Assuming base doesn't change for a near future. 
  base = 'https://aqs.epa.gov/data/api/'
  query = paste( base, endpoint, "?", sep = '' )
  return(query)
}

# Consider modifying to iterate over variables someone might call
query <- function( base_query, authentication  ){
  call <- paste( base_query, authentication, sep = '' )
  return( call )
}

# Append a state variable fips code to a query
add.state <- function( query, state.code ){
  result = paste( query, '&state=', state.code, sep = "")
  return(result)
}

# Take a query, add the beginning date
add.bdate <- function( query, bdate ){
  result <- paste( query,'&bdate=', bdate, sep = "" )
  return( result )
}

# Take a query add the ending date
add.edate <- function( query, edate ){
  result <- paste( query, '&edate=', edate, sep = "" )
  return( result )
}

# Add a parameter to a query
add.param <- function( query, param ){
  result <- paste( query, '&param=', param, sep = "" )
  return( result )
}

