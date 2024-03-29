% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/annual_summary_service.R
\name{get_annual_summary_in_county}
\alias{get_annual_summary_in_county}
\title{Get annual summary data in a county.}
\usage{
get_annual_summary_in_county(
  bdate,
  edate,
  state.fips,
  county,
  param,
  cached = TRUE,
  cache_directory = "/cache",
  cbdate = NULL,
  cedate = NULL
)
}
\arguments{
\item{bdate}{Beginning date to check.
Year, month, day format.}

\item{edate}{Ending date to check.
Year, month, day format.}

\item{state.fips}{State FIPS code.
Use get_state_fips() if unsure.}

\item{county}{County code. 
Use get_counties_in_state() if unsure.}

\item{param}{Pollutant parameter that site is measuring.}

\item{cached}{TRUE or FALSE specifying if the data from the call is to 
be cached. Default: TRUE. (Optional)}

\item{cache_directory}{Place inside user-level cache directory to store 
the cached data. Default: "/cache". (Optional)}

\item{cbdate}{Beginning date of last change to DB. (Optional)}

\item{cedate}{Ending date of last change to DB. (Optional)}
}
\value{
API response containing annual summary data in a county.
}
\description{
Get annual summary data in a county.
}
\examples{
\dontrun{
bdate <- "20200101"
edate <- "20200102"
state.fips <- "37"
county <- "001"
param <- "42401"
result <- get_annual_summary_in_county(bdate,
                                       edate,
                                       state.fips,
                                       county,
                                       param)
result$Data
}
}
