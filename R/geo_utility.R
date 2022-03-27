#' Internal function to perform geospatial 
#' lookup by Core Based Statistical Area.
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param cbsa An encoding for a Core Base Statiscal Area.
#' If unsure, use get_cbsas().
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' @return API response containing data at the cbsa level.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' cbsa <- "16740"
#' param <- "42401"
#' result <- lookup_by_cbsa(MONITORS, bdate, edate, param, cbsa)
#' result$Data
#' }
lookup_by_cbsa <- function(endpoint, 
                           bdate, 
                           edate, 
                           param, 
                           cbsa,
                           cached = TRUE,
                           cache_directory = "/cache",
                           duration = NULL,
                           cbdate = NULL,
                           cedate = NULL){
  base.url <- paste(endpoint, BY_CBSA, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "cbsa" = cbsa)
  if(!is.null(duration)){
    base.params[["duration"]] <- duration
  }
  if(!is.null(cbdate) & !is.null(cedate)){
    base.params[["cbdate"]] <- cbdate
    base.params[["cedate"]] <- cedate
  }
  result <- perform.call(base.url,
                         variables = base.params,
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}

#' Internal function to perform geospatial lookup by bounding box (lat, long).
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param minlat Minimum latitude coordinate.
#' @param maxlat Maximum latitude coordinate.
#' @param minlong Minimum longitude coordinate.
#' @param maxlong Maximum longitude coordinate.
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' @return API response containing bbox bounded data.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' param <- "42401"
#' minlat <- 33.3
#' maxlat <- 33.6
#' minlong <- -87
#' maxlong <- -86.7
#' result <- lookup_by_bbox(MONITORS, bdate, 
#'                                    edate, 
#'                                    param, 
#'                                    minlat, 
#'                                    maxlat, 
#'                                    minlong, 
#'                                    maxlong)
#' result$Data
#' }
lookup_by_bbox <- function(endpoint,
                           bdate,
                           edate,
                           param,
                           minlat,
                           maxlat,
                           minlong,
                           maxlong,
                           cached = TRUE,
                           cache_directory = "/cache",
                           duration = NULL,
                           cbdate = NULL,
                           cedate = NULL){
  base.url <- paste(endpoint, BY_BBOX, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "minlat" = minlat,
                      "maxlat" = maxlat,
                      "minlon" = minlong,
                      "maxlon" = maxlong)
  if(!is.null(duration)){
    base.params[["duration"]] <- duration
  }
  if(!is.null(cbdate) & !is.null(cedate)){
    base.params[["cbdate"]] <- cbdate
    base.params[["cedate"]] <- cedate
  }
  result <- perform.call(base.url,
                         variables = base.params,
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}

#' Internal function to perform geospatial lookup by state.
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param state.fips State FIPS code.
#' Use get_state_fips() if unsure.
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' @return API response containing operational information
#' about the monitor.
#' 
#' @examples
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' param <- "42401"
#' result <- lookup_by_state(MONITORS, bdate, edate, state.fips, param)
#' result$Data
#' }
lookup_by_state <- function(endpoint, 
                            bdate, 
                            edate, 
                            state.fips,
                            param,
                            cached = TRUE,
                            cache_directory = "/cache",
                            duration = NULL,
                            cbdate = NULL,
                            cedate = NULL){
  base.url <- paste(endpoint, BY_STATE, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "state" = state.fips)
  if(!is.null(duration)){
    base.params[["duration"]] <- duration
  }
  if(!is.null(cbdate) & !is.null(cedate)){
    base.params[["cbdate"]] <- cbdate
    base.params[["cedate"]] <- cedate
  }
  result <- perform.call(base.url,
                         variables = base.params,
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}

#' Internal function to perform geospatial lookup by site.
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param state.fips State FIPS code.
#' Use get_state_fips() if unsure.
#' @param county County code. 
#' Use get_counties_in_state() if unsure.
#' @param param Pollutant parameter that site is measuring.
#' @param site Measurement site code.
#' Use get_sites_by_county() if unsure.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' @return API response containing operational information
#' about the monitor.
#' 
#' @examples
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' county <- "001"
#' site <- "001"
#' param <- "42401"
#' result <- lookup_by_site(MONITORS, 
#'                          bdate, 
#'                          edate, 
#'                          state.fips, 
#'                          county, 
#'                          param, 
#'                          site)
#' result$Data
#' }
lookup_by_site <- function(endpoint, 
                           bdate, 
                           edate, 
                           state.fips, 
                           county, 
                           param,
                           site,
                           cached = TRUE,
                           cache_directory = "/cache",
                           duration = NULL,
                           cbdate = NULL,
                           cedate = NULL){
  base.url <- paste(endpoint, BY_SITE, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "state" = state.fips,
                      "county" = county,
                      "site" = site)
  if(!is.null(duration)){
    base.params[["duration"]] <- duration
  }
  if(!is.null(cbdate) & !is.null(cedate)){
    base.params[["cbdate"]] <- cbdate
    base.params[["cedate"]] <- cedate
  }
  result <- perform.call(base.url,
                         variables = base.params,
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}

#' Internal function to perform geospatial lookup by county.
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param state.fips State FIPS code.
#' Use get_state_fips() if unsure.
#' @param county County code. 
#' Use get_counties_in_state() if unsure.
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' @return API response containing operational information
#' about the monitor.
#' 
#' @examples
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' county <- "001"
#' param <- "42401"
#' result <- lookup_by_county(MONITORS, bdate, edate, state.fips, county, param)
#' result$Data
#' }
lookup_by_county <- function(endpoint, 
                             bdate, 
                             edate, 
                             state.fips, 
                             county, 
                             param,
                             cached = TRUE,
                             cache_directory = "/cache",
                             duration = NULL,
                             cbdate = NULL,
                             cedate = NULL){
  base.url <- paste(endpoint, BY_COUNTY, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "state" = state.fips,
                      "county" = county)
  if(!is.null(duration)){
    base.params[["duration"]] <- duration
  }
  if(!is.null(cbdate) & !is.null(cedate)){
    base.params[["cbdate"]] <- cbdate
    base.params[["cedate"]] <- cedate
  }
  result <- perform.call(base.url,
                         variables = base.params,
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}

#' Internal function to perform geospatial 
#' lookup by primary quality assurance organization.
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param pqao An encoding for a Primary Quality Assurance Organization.
#' If unsure, use get_all_pqaos().
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20201231"
#' param <- "44201"
#' pqao <- "0013"
#' result <- lookup_by_pqao(QA_APE, bdate, edate, param, pqao)
#' result$Data
#' }
lookup_by_pqao <- function(endpoint, 
                           bdate, 
                           edate, 
                           param, 
                           pqao,
                           cached = TRUE,
                           cache_directory = "/cache"){
  base.url <- paste(endpoint, BY_PQAO, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "pqao" = pqao)
  
  result <- perform.call(base.url,
                         variables = base.params, 
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}



#' Internal function to perform geospatial 
#' lookup by monitoring agency.
#' 
#' @param endpoint Base url to make call.
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param agency The monitoring agency.
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20201231"
#' param <- "44201"
#' agency <- "0013"
#' result <- lookup_by_ma(QA_APE, bdate, edate, param, agency)
#' result$Data
#' }
lookup_by_ma <- function(endpoint, 
                         bdate, 
                         edate, 
                         param, 
                         agency,
                         cached = TRUE,
                         cache_directory = "/cache"){
  base.url <- paste(endpoint, BY_MA, sep="/")
  base.params <- list("bdate" = bdate,
                      "edate" = edate,
                      "param" = param,
                      "agency" = agency)
  
  result <- perform.call(base.url,
                         variables = base.params,
                         cached = cached,
                         cache_directory = cache_directory)
  return(result)
}