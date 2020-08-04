# epair

A package designed to aid in getting data from the Environmental Protection Agency (EPA) API at
https://aqs.epa.gov/aqsweb/documents/data_api.

### Overview

The `epair` package helps you determine what data you want and how to get that data from the EPA API.
It provides loaded in variables that help you navigate services in the API, and a simple way to query the data. 

```
library(epair)
endpoint <- "dailyData/byState"
vars <-  list(bdate = "20190101",
              edate = "20190131",
              param = "44201",    # Ozone
              state = "02")       # Alaska
result <- perform.call(endpoint, vars)
alaska <- result$Data
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

### Learn how to use

A comprehensive tutorial for using `epair` can be found at https://epair.netlify.app/. 


