% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_transforms.R
\name{list.remove.escapes.spaces}
\alias{list.remove.escapes.spaces}
\title{Remove tabs, new lines, and empty spaces from entries in a list}
\usage{
list.remove.escapes.spaces(a.list)
}
\arguments{
\item{a.list}{List to remove entries from.}
}
\value{
A list without tabs, new lines, and empty spaces
}
\description{
Remove tabs, new lines, and empty spaces from entries in a list
}
\examples{
service <- c("Sign up")
description <- c("Email will\r\n\t\t\t\t\t\t\t be sent to the registered
address from aqsdatamart@epa.gov.")

og_list <- list("service" = service, "description" = description)
clean <- epair:::remove.escapes.spaces(og_list)
clean
}
