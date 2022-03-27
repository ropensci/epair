#' Get samples (finest grained data) for a bounding box (lat, long).
#' 
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
#' @return API response containing operational information
#' about the monitor.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' param <- "42401"
#' minlat <- 33.3
#' maxlat <- 33.6
#' minlong <- -87
#' maxlong <- -86.7
#' result <- get_samples_in_bbox(bdate = bdate,
#'                               edate = edate,
#'                               param = param,
#'                               minlat = minlat,
#'                               maxlat = maxlat,
#'                               minlong = minlong,
#'                               maxlong = maxlong)
#' result$Data
#' }
get_samples_in_bbox <- function(bdate,
                                edate,
                                minlat,
                                maxlat,
                                minlong,
                                maxlong,
                                param,
                                cached = TRUE,
                                cache_directory = "/cache",
                                duration = NULL,
                                cbdate = NULL,
                                cedate = NULL){
  result <- lookup_by_bbox(endpoint = SAMPLE,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           minlat = minlat,
                           maxlat = maxlat,
                           minlong = minlong,
                           maxlong = maxlong,
                           cached = cached,
                           cache_directory = cache_directory,
                           duration = duration,
                           cbdate = cbdate,
                           cedate = cedate)
  return(result)
}

#' Get samples (finest grained data) for a Core Based Statistical Area.
#' 
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param param Pollutant parameter that site is measuring.
#' @param cbsa An encoding for a Core Base Statiscal Area.
#' If unsure, use get_cbsas().
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#' @return API response containing sample measurements in a CBSA.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' cbsa <- "16740"
#' param <- "42401"
#' result <- get_samples_in_cbsa(bdate, edate, cbsa, param)
#' result$Data
#' }
get_samples_in_cbsa <- function(bdate,
                                edate,
                                param,
                                cbsa,
                                cached = TRUE,
                                cache_directory = "/cache",
                                duration = NULL,
                                cbdate = NULL,
                                cedate = NULL){
  result <- lookup_by_cbsa(endpoint = SAMPLE,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           cbsa = cbsa,
                           cached = cached,
                           cache_directory = cache_directory,
                           duration = duration,
                           cbdate = cbdate,
                           cedate = cedate)
  return(result)
}

#' Get samples (finest grained data) for a county.
#' 
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param state.fips State FIPS code.
#' Use get_state_fips() if unsure.
#' @param param Pollutant parameter that site is measuring.
#' @param county County code. 
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#' @return API response containing sample measurements in a state.
#' @examples 
#' \dontrun{
#' bdate <- "20160101"
#' edate <- "20160102"
#' state.fips <- "15"
#' county <- "001"
#' param <- "42401"
#' result <- get_samples_in_county(bdate = bdate,
#'                                 edate = edate,
#'                                 param = param,
#'                                 state.fips = state.fips,
#'                                 county = county)
#' result$Data
#' } 
get_samples_in_county <- function(bdate,
                                  edate,
                                  state.fips,
                                  param,
                                  county,
                                  cached = TRUE,
                                  cache_directory = "/cache",
                                  duration = NULL,
                                  cbdate = NULL,
                                  cedate = NULL){
  result <- lookup_by_county(endpoint = SAMPLE,
                             bdate = bdate,
                             edate = edate,
                             state.fips = state.fips,
                             param = param,
                             county = county,
                             cached = cached,
                             cache_directory = cache_directory,
                             duration  = duration,
                             cbdate = cbdate,
                             cedate = cedate)
  return(result)
}

#' Get samples (finest grained data) for a state.
#' 
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
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#' @return API response containing sample measurements in a state.
#' @examples
#' \dontrun{
#' bdate <- "20160101"
#' edate <- "20160102"
#' state.fips <- "15"
#' param <- "42401"
#' result <- get_samples_in_state(bdate = bdate, 
#'                                edate = edate, 
#'                                param = param, 
#'                                state.fips = state.fips)
#' result$Data
#' }
get_samples_in_state <- function(bdate = bdate,
                                 edate = edate,
                                 state.fips = state.fips,
                                 param = param,
                                 cached = TRUE,
                                 cache_directory = "/cache",
                                 duration = NULL,
                                 cbdate = NULL,
                                 cedate = NULL){
  result <- lookup_by_state(endpoint = SAMPLE,
                            bdate = bdate,
                            edate = edate,
                            state.fips = state.fips,
                            param = param,
                            cached = cached,
                            cache_directory = cache_directory,
                            duration = duration,
                            cbdate = cbdate,
                            cedate = cedate)
  return(result)
}

#' Get samples (finest grained data) for a measurement site.
#' 
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param state.fips State FIPS code.
#' Use get_state_fips() if unsure.
#' @param county County code. 
#' Use get_counties_in_state() if unsure.
#' @param site Measurement site code.
#' Use get_sites_by_county() if unsure.
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param duration The 1-character AQS sample duration code. (Optional)
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#'
#' @return API response containing samples at given site.
#' 
#' @examples 
#' \dontrun{
#' bdate <- "20160101"
#' edate <- "20160102"
#' state.fips <- "15"
#' county <- "001"
#' param <- "42401"
#' site <- "0007"
#' cbdate <- "20200101"
#' cedate <- "20201231"
#' result <- get_samples_in_site(bdate = bdate, 
#'                               edate = edate, 
#'                               param = param, 
#'                               state.fips = state.fips,
#'                               county = county,
#'                               site = site)
#' result$Data
#' }
get_samples_in_site <- function(bdate, 
                                edate,
                                state.fips,
                                county,
                                site,
                                param,
                                cached = TRUE,
                                cache_directory = "/cache",
                                duration = NULL,
                                cbdate = NULL,
                                cedate = NULL){
  result <- lookup_by_site(endpoint = SAMPLE,
                           bdate = bdate,
                           edate = edate,
                           state.fips = state.fips,
                           county = county,
                           param = param,
                           cached = cached,
                           cache_directory = cache_directory,
                           duration = duration,
                           cbdate = cbdate,
                           cedate = cedate,
                           site = site)
  return(result)
}
