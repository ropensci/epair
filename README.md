# epair

<!-- badges: start -->
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4309792.svg)](https://doi.org/10.5281/zenodo.4309792)
[![R-CMD-check](https://github.com/GLOrozcoM/epair/workflows/R-CMD-check/badge.svg)](https://github.com/GLOrozcoM/epair/actions)
<!-- badges: end -->

A package designed to aid in getting data from the Environmental Protection Agency (EPA) API at
https://aqs.epa.gov/aqsweb/documents/data_api.html.

### Overview

The `epair` package helps you determine what data you want and how to get that data from the EPA API.
It provides loaded in variables that help you navigate services in the API, and a simple way to query the data. A comprehensive site for using `epair` can be found at https://glorozcom.github.io/epair/. 

Broadly, you can explore possible calls by typing `epair::get_` and seeing what autocomplete offers in R. 
Most of these functions require a start and end date along with a geographical boundary type (like CBSA code or bounding box). For more details, we recommend looking at the help docs `?epair::get_[type]()` for the function you're interested in using to see the exact required params.

### Installation

You can download the latest release from this repo using `devtools`. 

```
devtools::install.github("GLOrozcoM/epair")
```

Or, download these files and in your working directory run

```
devtools::install("GLOrozcoM/epair")
```

`epair` depends on `httr` for making its data calls and `rvest` for creating the variables loaded in with the package. We recommend having `httr` installed (automatically taken care of through package dependencies), and only installing `rvest` if you're curious about how package variables were made.

## Usage notes

Note that currently a single call to AQS allows for at maximum a single year's worth of data. You'll need to create separate calls to get multiple year's worth of data.

### ropenaq

You may want to check out `ropenaq` instead depending on the goals behind your study. `ropenaq` is an R wrapper for accessing the OpenAQ API - see its website [here](https://docs.ropensci.org/ropenaq/). Here are a few differences:

* `epair` will get data from a single source (EPA AQS API), while `ropenaq` will be more useful if you’re trying to compare data from different sources.

* If you're interested in data for the US only, `epair` would be an appropriate choice. For more locations across the world, `ropenaq` would work better. 

* `epair’s` data source does offer more granularity than OpenAQ for US data. The EPA AQS API can give over 500 parameters/pollutants of interest (as opposed to OpenAQ’s 5), county level coverage, and unaggregated raw data. By default, OpenAQ will give aggregated data so if you're only interested in aggregations, then OpenAQ is the way to go. 

### Terms of Service

Make sure you also see the Usage Tips and Terms of Service associated with using this API at https://aqs.epa.gov/aqsweb/documents/data_api.html. 