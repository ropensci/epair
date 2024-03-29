% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monitors_service.R
\name{get_monitors_in_cbsa}
\alias{get_monitors_in_cbsa}
\title{Get monitors within a Core Based Statistical Area.}
\usage{
get_monitors_in_cbsa(
  bdate,
  edate,
  param,
  cbsa,
  cached = TRUE,
  cache_directory = "/cache"
)
}
\arguments{
\item{bdate}{Beginning date to check.
Year, month, day format.}

\item{edate}{Ending date to check.
Year, month, day format.}

\item{param}{Pollutant parameter that site is measuring.}

\item{cbsa}{An encoding for a Core Base Statiscal Area.
If unsure, use get_cbsas().}

\item{cached}{TRUE or FALSE specifying if the data from the call is to 
be cached. Default: TRUE. (Optional)}

\item{cache_directory}{Place inside user-level cache directory to store 
the cached data. Default: "/cache". (Optional)}
}
\value{
API response containing operational information
about the monitor.
}
\description{
Get monitors within a Core Based Statistical Area.
}
\examples{
\dontrun{
bdate <- "20200101"
edate <- "20200102"
cbsa <- "16740"
param <- "42401"
result <- get_monitors_in_cbsa(bdate, edate, param, cbsa)
result$Data
}
}
