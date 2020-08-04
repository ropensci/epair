---
title: 'epair: An R package for acquiring EPA data easily'
tags:
  - R
  - EPA API
  - pollutant data
  - environmental data
authors:
  - name: George Leonard Orozco-Mulfinger
    orcid: TODO
    affiliation: TODO
  - name: Owais Gilani
    affiliation: Bucknell University
affiliations:
 - name: Michael Kane, Yale University
   index: 1
date: 14 August 2020
bibliography: paper.bib
---

# Summary

R users trying to get data from the Environmental Protection Agency (EPA) API may run into 
unexpected difficulties. Getting data requires a knowledge of API's, an aptitude for managing JSON files, understanding
specific parameter codes for desired filtering of data, and knowledge of the range of EPA API services
offered. This package simplifies the process of getting data at each step - from determining 
what services are available, to simple placement of data calls to the EPA API. Researchers looking to use EPA data can skip time and setup intensive steps in their workflow by using this package.


# Statement of need 

`epair` is an R package that helps facilitate downloading air quality data from the US Environmental Protection Agency’s (EPA) Air Quality System (AQS) (https://www.epa.gov/aqs) API. The US EPA records and maintains air quality data from a variety of sources and on various spatial and temporal domains. These data are used by researchers from diverse domains including statistics, environmental sciences, environmental health, climate change, physics, atmospheric sciences, and epidemiology, to name a few. Previously, to download these data users had to use an online form by selecting a data source, pollutant, time and spatial domains etc. Recently, the downloading procedure was changed by the EPA to an API where users are now required to build an API call which consists of various components, including a base URL, an end point, authentication code, and potential variables. Building such calls can be fairly complicated and time consuming for those not familiar with the AQS data sources and formats, as well as those not used to working with such APIs.

 

`epair` was developed to help users download these data directly from R using a framework that beginner R users would be familiar with. It includes some interactive features that help the users explore what data they need to download, and to determine what parameters they need pass to the API to get their data. It thus allows users to document their data download/access process along with their analysis code for improved reproducibility and reliability. `epair` relies heavily on the packages `rvest` and `httr`. It has been used in recent scientific publications modeling ozone concentrations in CT [@gilani:2019], and is currently being used in other research projects exploring the impact of COVID-19 on air pollution concentrations.

# Examples

In this example we replicate acquiring data used in [@gilani:2019]. The data section of (Gilani et al) requires Ozone concentrations in the state of CT from July 6 to August 5, 2016. Using `epair`, acquiring these data would reduce to the following. 

### Finding the appropriate parameter codes for data calls

Make sure the package is loaded.

```
library(epair)
```

Determining appropriate variables and parameters for the call can be done using `services` and `variables` that come loaded with `epair`. 

To find the proper endpoint we can simply use
```
services$`Sample Data`$Filters$`By State`$Endpoint
```

For the state of CT, we find its parameter code through
```
endpoint <- services$List$Filters$States$Endpoint
perform.call(endpoint)
```

Finally, to find the parameter code for Ozone, we can try
```
endpoint <- "list/parametersByClass"
pc <- "AQI%20POLLUTANTS"
perform.call(endpoint, pc)
```

### Making the data call

To acquire the data, the following three lines suffice.
```
endpoint <- "sampleData/byState"
vars <- list(state = "09", bdate = "20160706", edate = "20160805", param = "44201")
perform.call(endpoint, vars)
```

### Further examples

The site at https://epair.netlify.app/ provides an in depth tutorial with more examples for using the 
package.

# Acknowledgements

We acknowledge the following testers for the beta version of the package TODO.

# References

TODO insert CT paper
