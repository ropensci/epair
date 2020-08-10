---
title: 'epair: An R package for acquiring EPA data easily'
tags:
  - R
  - EPA API
  - pollutant data acquisition
  - environmental data acquisition
authors:
  - name: George Leonard Orozco-Mulfinger^[corresponding author]
    orcid: 0000-0002-9011-409X
    affiliation: 1
  - name: Owais Gilani
    orcid: 0000-0002-0402-6975
    affiliation: 2
  - name: Michael J. Kane
    orcid: 0000-0003-1899-6662
    affiliation: 3
affiliations:
  - name: Independent Researcher
    index: 1
  - name: Bucknell University
    index: 2
  - name: Yale University
    index: 3
date: 14 August 2020
bibliography: paper.bib

---

# Summary

R users trying to get data from the Environmental Protection Agency (EPA) API may run into 
unexpected difficulties. Getting data requires a knowledge of APIs, an aptitude for managing JSON files, understanding
specific parameter codes for desired filtering of data, and knowledge of the range of EPA API services
offered. This package simplifies the process of getting data at each step - from determining 
what services are available, to simple placement of data calls to the EPA API. Researchers looking to use EPA data can skip time and setup intensive steps in their workflow by using this package.


# Statement of need 

`epair` is an R package that helps facilitate downloading air quality data from the US Environmental Protection Agency’s (EPA) Air Quality System (AQS) [@EPA] API. The US EPA records and maintains air quality data from a variety of sources and on various spatial and temporal domains. These data are used by researchers from diverse domains including statistics, environmental sciences, environmental health, climate change, physics, atmospheric sciences, and epidemiology, to name a few. Previously, to download these data users had to use an online form by selecting a data source, pollutant, time and spatial domains etc. Recently, the downloading procedure was changed by the EPA to an API where users are now required to build an API call which consists of various components, including a base URL, an end point, authentication code, and potential variables. Building such calls can be fairly complicated and time consuming for those not familiar with the AQS data sources and formats, as well as those not used to working with such APIs.

`epair` was developed to help users download these data directly from R using a framework that beginner R users would be familiar with. It includes some interactive features that help the users explore what data they need to download, and to determine what parameters they need pass to the API to get their data. It thus allows users to document their data download/access process along with their analysis code for improved reproducibility and reliability. `epair` relies heavily on the packages `rvest` and `httr`. It has been used in recent scientific publications modeling ozone concentrations in Connecticut, USA [@Gilani:2020], and is currently being used in other research projects exploring the impact of COVID-19 on air pollution concentrations.

# Example

In this example we replicate acquiring data used in [@Gilani:2020]. The data section of [@Gilani:2020] requires ozone concentrations in the state of Connecticut from July 6 to August 5, 2016. A potential workflow to getting these data with `epair` is given below. The site at https://epair.netlify.app/ provides an in depth tutorial with more examples on using the package.

### Finding the appropriate parameter codes for data calls

Make sure the package is loaded.

```
library(epair)
```

To find the proper endpoint we can simply use
```
> services$`Sample Data`$Filters$`By State`$Endpoint
[1] "sampleData/byState"
```

For the state of CT, we find its parameter code by listing states and their respective codes through
```
> endpoint <- services$List$Filters$States$Endpoint
> result <- perform.call(endpoint)
> result$Data
   code    value_represented
1    01              Alabama
2    02               Alaska
3    04              Arizona
4    05             Arkansas
5    06           California
6    08             Colorado
7    09          Connecticut
8    10             Delaware
...
```

Finally, to find the parameter code for ozone, we list the parameter codes associated with AQI Pollutants. 
```
> endpoint <- "list/parametersByClass"
> pc <- "AQI%20POLLUTANTS"
> result <- perform.call(endpoint, pc)
> result$Data
   code                      value_represented
1 42101                        Carbon monoxide
2 42401                         Sulfur dioxide
3 42602                 Nitrogen dioxide (NO2)
4 44201                                  Ozone
5 81102                  PM10 Total 0-10um STP
6 88101               PM2.5 - Local Conditions
7 88502 Acceptable PM2.5 AQI & Speciation Mass
```

### Making the data call

To acquire the data, the following lines suffice.
```
> endpoint <- "sampleData/byState"
> vars <- list(state = "09", bdate = "20160706", edate = "20160805", param = "44201")
> result <- perform.call(endpoint, vars)
```

# Similar packages

Another existing package, `aqsr` found at https://github.com/jpkeller/aqsr is similar in aims to `epair`, and we here mention key differences. 

`epair` provides a comprehensive `services` variable to help the user explore EPA API services from R.
For instance, besides just listing all available services using `names(services)`, the user can check a description, available filters, endpoints associated with filters, required and optional variables, and 
examples. `epair` also offers `variables`, a list with helpful descriptions for the user to know more about variables in EPA API. `epair` uses only two functions, `perform.call()` and `perform.call.raw()`, to obtain data from the EPA API. In each case, the user can use `services` to determine the appropriate endpoints and filters to apply to the query. `epair` provides documentation for each function, internal and external, as well as a PDF manual with usage examples for each function.

# References
