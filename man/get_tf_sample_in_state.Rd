% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tf_sample_service.R
\name{get_tf_sample_in_state}
\alias{get_tf_sample_in_state}
\title{Get sample data in the transaction format in a state.}
\usage{
get_tf_sample_in_state(
  bdate,
  edate,
  state.fips,
  param,
  cached = TRUE,
  cache_directory = "/cache"
)
}
\arguments{
\item{bdate}{Beginning date to check.
Year, month, day format.}

\item{edate}{Ending date to check.
Year, month, day format.}

\item{state.fips}{State FIPS code.
Use get_state_fips() if unsure.}

\item{param}{Pollutant parameter that site is measuring.}

\item{cached}{TRUE or FALSE specifying if the data from the call is to 
be cached. Default: TRUE. (Optional)}

\item{cache_directory}{Place inside user-level cache directory to store 
the cached data. Default: "/cache". (Optional)}
}
\value{
API response containing all sample data in submission format.
}
\description{
Get sample data in the transaction format in a state.
}
\examples{
\dontrun{
bdate <- "20200101"
edate <- "20200331"
state.fips <- "01"
param <- "44201"
result <- get_tf_sample_in_state(bdate, edate, state.fips, param)
result$Data
}
}
