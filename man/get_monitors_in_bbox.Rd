% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monitors_service.R
\name{get_monitors_in_bbox}
\alias{get_monitors_in_bbox}
\title{Get all monitoring sites within a bounding box (lat, long).}
\usage{
get_monitors_in_bbox(
  bdate,
  edate,
  param,
  minlat,
  maxlat,
  minlong,
  maxlong,
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

\item{minlat}{Minimum latitude coordinate.}

\item{maxlat}{Maximum latitude coordinate.}

\item{minlong}{Minimum longitude coordinate.}

\item{maxlong}{Maximum longitude coordinate.}

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
Get all monitoring sites within a bounding box (lat, long).
}
\examples{
\dontrun{
bdate <- "20200101"
edate <- "20200102"
param <- "42401"
minlat <- 33.3
maxlat <- 33.6
minlong <- -87
maxlong <- -86.7
result <- get_monitors_in_bbox(bdate, 
                              edate, 
                              param, 
                              minlat, 
                              maxlat, 
                              minlong, 
                              maxlong)
result$Data
}
}
