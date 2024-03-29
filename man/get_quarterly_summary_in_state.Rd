% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quarterly_service.R
\name{get_quarterly_summary_in_state}
\alias{get_quarterly_summary_in_state}
\title{Get quarterly summary data in a state.}
\usage{
get_quarterly_summary_in_state(
  bdate,
  edate,
  state.fips,
  param,
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

\item{param}{Pollutant parameter that site is measuring.}

\item{cbdate}{Beginning date of last change to DB. (Optional)}

\item{cedate}{Ending date of last change to DB. (Optional)}
}
\value{
API response containing quarterly summary data for a state.
}
\description{
Get quarterly summary data in a state.
}
\examples{
\dontrun{
bdate <- "20200101"
edate <- "20200102"
state.fips <- "37"
param <- "42401"
result <- get_quarterly_summary_in_state(bdate,
                                         edate,
                                         state.fips,
                                         param)
result$Data
}
}
