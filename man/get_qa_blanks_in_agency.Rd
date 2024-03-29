% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qa_blanks_service.R
\name{get_qa_blanks_in_agency}
\alias{get_qa_blanks_in_agency}
\title{Get quality assurance blank data for a monitoring agency.}
\usage{
get_qa_blanks_in_agency(
  bdate,
  edate,
  param,
  agency,
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

\item{agency}{The monitoring agency.}

\item{cached}{TRUE or FALSE specifying if the data from the call is to 
be cached. Default: TRUE. (Optional)}

\item{cache_directory}{Place inside user-level cache directory to store 
the cached data. Default: "/cache". (Optional)}
}
\value{
API response containing operational information
about the quality assurance blank data.
}
\description{
Get quality assurance blank data for a monitoring agency.
}
\examples{
\dontrun{
bdate <- "20180101"
edate <- "20180131"
param <- "88101"
agency <- "0013"
result <- get_qa_blanks_in_agency(bdate, 
                              edate, 
                              param, 
                              agency)
result$Data
}
}
