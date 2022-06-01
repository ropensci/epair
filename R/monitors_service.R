#' Get all monitors at a site.
#' 
#' @export
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
#' @return API response containing operational information
#' about the monitor.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' county <- "001"
#' param <- "42401"
#' site <- "001"
#' result <- get_monitors_in_site(bdate, edate, state.fips, county, param, site)
#' result$Data
#' } 
get_monitors_in_site <- function(bdate, 
                                 edate, 
                                 state.fips, 
                                 county, 
                                 param, 
                                 site,
                                 cached = TRUE,
                                 cache_directory = "/cache"){
  result <- lookup_by_site(endpoint = MONITORS,
                           bdate = bdate,
                           edate = edate,
                           state.fips = state.fips,
                           county = county,
                           param = param,
                           site = site,
                           cached = cached,
                           cache_directory = cache_directory)
  return(result)
}

#' Get all monitors in a county.
#' 
#' @export
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
#' @return API response containing operational information
#' about the monitor.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' county <- "001"
#' param <- "42401"
#' result <- get_monitors_in_county(bdate, edate, state.fips, county, param)
#' result$Data
#' }
get_monitors_in_county <- function(bdate, 
                                   edate, 
                                   state.fips, 
                                   county, 
                                   param,
                                   cached = TRUE,
                                   cache_directory = "/cache"){
  result <- lookup_by_county(endpoint = MONITORS, 
                             bdate = bdate, 
                             edate = edate, 
                             state.fips = state.fips, 
                             county = county, 
                             param = param,
                             cached = cached,
                             cache_directory = cache_directory)
  return(result)
}

#' Get monitors in state.
#' 
#' @export
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
#' @return API response containing operational information
#' about the monitor.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' param <- "42401"
#' result <- get_monitors_in_state(bdate, edate, state.fips, param)
#' result$Data
#' }
get_monitors_in_state <- function(bdate, 
                                  edate, 
                                  state.fips, 
                                  param,
                                  cached = TRUE,
                                  cache_directory = "/cache"){
  result <- lookup_by_state(endpoint = MONITORS,
                            bdate = bdate,
                            edate = edate,
                            state.fips = state.fips,
                            param = param,
                            cached = cached,
                            cache_directory = cache_directory)
  return(result)
}

#' Get monitors within a Core Based Statistical Area.
#' @export
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
#' @return API response containing operational information
#' about the monitor.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' cbsa <- "16740"
#' param <- "42401"
#' result <- get_monitors_in_cbsa(bdate, edate, param, cbsa)
#' result$Data
#' }
get_monitors_in_cbsa <- function(bdate, 
                                 edate, 
                                 param, 
                                 cbsa,
                                 cached = TRUE,
                                 cache_directory = "/cache"){
  result <- lookup_by_cbsa(endpoint = MONITORS,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           cbsa = cbsa,
                           cached = cached,
                           cache_directory = cache_directory)
  return(result)
}

#' Get all monitoring sites within a bounding box (lat, long).
#' 
#' @export
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param param Pollutant parameter that site is measuring.
#' @param minlat Minimum latitude coordinate.
#' @param maxlat Maximum latitude coordinate.
#' @param minlong Minimum longitude coordinate.
#' @param maxlong Maximum longitude coordinate.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
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
#' result <- get_monitors_in_bbox(bdate, 
#'                               edate, 
#'                               param, 
#'                               minlat, 
#'                               maxlat, 
#'                               minlong, 
#'                               maxlong)
#' result$Data
#' }
get_monitors_in_bbox <-  function(bdate, 
                                  edate, 
                                  param, 
                                  minlat, 
                                  maxlat, 
                                  minlong, 
                                  maxlong,
                                  cached = TRUE,
                                  cache_directory = "/cache"){
  result <- lookup_by_bbox(endpoint = MONITORS,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           minlat = minlat,
                           maxlat = maxlat,
                           minlong = minlong,
                           maxlong = maxlong,
                           cached = cached,
                           cache_directory = cache_directory)
  return(result)
}
