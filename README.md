# epair

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4309792.svg)](https://doi.org/10.5281/zenodo.4309792)


A package designed to aid in getting data from the Environmental Protection Agency (EPA) API at
https://aqs.epa.gov/aqsweb/documents/data_api.

### Overview

The `epair` package helps you determine what data you want and how to get that data from the EPA API.
It provides loaded in variables that help you navigate services in the API, and a simple way to query the data. A comprehensive tutorial for using `epair` can be found at https://epair.netlify.app/. 

Easily find the endpoint you need. 
```
> services$`Daily Summary Data`$Filters$`By State`$Endpoint
[1] "dailyData/byState"
```

Place the call.

```
> endpoint <- "dailyData/byState"
> vars <-  list(bdate = "20190101",
                edate = "20190131",
                param = "44201",    # Ozone
                state = "02")       # Alaska
> result <- perform.call(endpoint, vars)
> alaska <- result$Data
##   state_code county_code site_number parameter_code poc latitude longitude
## 1         02         068        0003          44201   1  63.7232 -148.9676
## 2         02         068        0003          44201   1  63.7232 -148.9676
## 3         02         068        0003          44201   1  63.7232 -148.9676
## 4         02         068        0003          44201   1  63.7232 -148.9676
## 5         02         068        0003          44201   1  63.7232 -148.9676
## 6         02         068        0003          44201   1  63.7232 -148.9676
##   datum parameter         sample_duration pollutant_standard date_local
## 1 WGS84     Ozone                  1 HOUR  Ozone 1-hour 1979 2019-01-01
## 2 WGS84     Ozone 8-HR RUN AVG BEGIN HOUR  Ozone 8-Hour 1997 2019-01-01
## 3 WGS84     Ozone 8-HR RUN AVG BEGIN HOUR  Ozone 8-Hour 2008 2019-01-01
## 4 WGS84     Ozone 8-HR RUN AVG BEGIN HOUR  Ozone 8-hour 2015 2019-01-01
## 5 WGS84     Ozone                  1 HOUR  Ozone 1-hour 1979 2019-01-02
## 6 WGS84     Ozone 8-HR RUN AVG BEGIN HOUR  Ozone 8-Hour 1997 2019-01-02
##    units_of_measure event_type observation_count observation_percent
## 1 Parts per million       None                24                 100
## 2 Parts per million       None                24                 100
## 3 Parts per million       None                24                 100
## 4 Parts per million       None                17                 100
## 5 Parts per million       None                24                 100
## 6 Parts per million       None                24                 100
##   validity_indicator arithmetic_mean first_max_value first_max_hour aqi
## 1                  Y        0.042667           0.045              9  NA
## 2                  Y        0.041917           0.044              5  41
## 3                  Y        0.041917           0.044              5  41
## 4                  Y        0.041588           0.044              7  41
## 5                  Y        0.036708           0.040              1  NA
## 6                  Y        0.035708           0.039              0  36
##   method_code                      method                 local_site_name
## 1         047 INSTRUMENTAL - ULTRA VIOLET Denali NP & PRES - Headquarters
## 2         047 INSTRUMENTAL - ULTRA VIOLET Denali NP & PRES - Headquarters
## 3         047 INSTRUMENTAL - ULTRA VIOLET Denali NP & PRES - Headquarters
## 4         047 INSTRUMENTAL - ULTRA VIOLET Denali NP & PRES - Headquarters
## 5         047 INSTRUMENTAL - ULTRA VIOLET Denali NP & PRES - Headquarters
## 6         047 INSTRUMENTAL - ULTRA VIOLET Denali NP & PRES - Headquarters
##           site_address  state  county          city cbsa_code cbsa
## 1 DENALI NATIONAL PARK Alaska Denali  Not in a city      <NA> <NA>
## 2 DENALI NATIONAL PARK Alaska Denali  Not in a city      <NA> <NA>
## 3 DENALI NATIONAL PARK Alaska Denali  Not in a city      <NA> <NA>
## 4 DENALI NATIONAL PARK Alaska Denali  Not in a city      <NA> <NA>
## 5 DENALI NATIONAL PARK Alaska Denali  Not in a city      <NA> <NA>
## 6 DENALI NATIONAL PARK Alaska Denali  Not in a city      <NA> <NA>
##   date_of_last_change
## 1          2020-02-26
## 2          2020-02-26
## 3          2020-02-26
## 4          2020-02-26
## 5          2020-02-26
## 6          2020-02-26
```

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

### Key features

Look at variables to glean more information on the kind of data call you want to make. 

* `services` provides an easy to use container for all services and required calling variables
for the API. 
* `variables` gives you information on all required calling variables. 
* `endpoints` offers a comprehensive list of every endpoint used in the API.

Place your call without having to worry about string manipulations or JSON files.

* `perform.call()` will take an endpoint and variables and provided the user with metadata and desired data as a dataframe. 
* `perform.call.raw()` will give the same results as `perform.call()` except for in JSON format.

### ropenaq

You may want to check out `ropenaq` instead depending on the goals behind your study. `ropenaq` is an R wrapper for accessing the OpenAQ API - see its website [here](https://docs.ropensci.org/ropenaq/). Here are a few differences:

* `epair` will get data from a single source (EPA AQS API), while `ropenaq` will be more useful if you’re trying to compare data from different sources.

* If you're interested in data for the US only, `epair` would be an appropriate choice. For more locations across the world, `ropenaq` would work better. 

* `epair’s` data source does offer more granularity than OpenAQ for US data. The EPA AQS API can give over 500 parameters/pollutants of interest (as opposed to OpenAQ’s 5), county level coverage, and unaggregated raw data. By default, OpenAQ will give aggregated data so if you're only interested in aggregations, then OpenAQ is the way to go. 

### Terms of Service

Make sure you also see the Usage Tips and Terms of Service associated with using this API at https://aqs.epa.gov/aqsweb/documents/data_api.html. 
