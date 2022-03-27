#' Returns data summarized by day at measurement site level.
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
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#'
#' @return API response containing daily data.
#' 
#' @examples 
#' \dontrun{
#' param <- 44201
#' bdate <- 20170618
#' edate <- 20170618
#' state <- 37
#' county <- 183
#' site <- 0014
#' result <- get_daily_summary_in_site(bdate,
#'                                     edate,
#'                                     state,
#'                                     county,
#'                                     site,
#'                                     param)
#' result$Data
#' }
get_daily_summary_in_site <- function(bdate, 
                                      edate,
                                      state.fips,
                                      county,
                                      site,
                                      param,
                                      cached = TRUE,
                                      cache_directory = "/cache",
                                      cbdate = NULL,
                                      cedate = NULL){
  result <- lookup_by_site(endpoint = DAILY,
                           bdate = bdate,
                           edate = edate,
                           state.fips = state.fips,
                           county = county,
                           param = param,
                           cached = cached,
                           cache_directory = cache_directory,
                           cbdate = cbdate,
                           cedate = cedate,
                           site = site)
  return(result)
}

#' Returns data summarized by day at the county level.
#' 
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
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#'
#' @return API response containing daily data.
#' 
#' @examples 
#' \dontrun{
#' param <- 44201
#' bdate <- 20170618
#' edate <- 20170618
#' state <- 37
#' county <- 183
#' result <- get_daily_summary_in_county(bdate,
#'                                     edate,
#'                                     state,
#'                                     county,
#'                                     param)
#' result$Data
#' }
get_daily_summary_in_county <- function(bdate,
                                        edate,
                                        state.fips,
                                        county,
                                        param,
                                        cached = TRUE,
                                        cache_directory = "/cache",
                                        cbdate = NULL,
                                        cedate = NULL){
  result <- lookup_by_county(endpoint = DAILY,
                             bdate = bdate,
                             edate = edate,
                             state.fips = state.fips,
                             county = county,
                             param = param,
                             cached = cached,
                             cache_directory = cache_directory,
                             cbdate = cbdate,
                             cedate = cedate)
  return(result)
}

#' Returns daily data at the state level.
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
#' @param cbdate Change begin date. (Optional) 
#' @param cedate Change end date. (Optional)
#'
#' @return API response containing daily data.
#' @examples 
#' \dontrun{
#' param <- 44201
#' bdate <- 20170618
#' edate <- 20170618
#' state <- 37
#' result <- get_daily_summary_in_state(bdate,
#'                                      edate,
#'                                      state,
#'                                      param)
#' result$Data
#' }
get_daily_summary_in_state <- function(bdate,
                                       edate,
                                       state.fips,
                                       param,
                                       cached = TRUE,
                                       cache_directory = "/cache",
                                       cbdate = NULL,
                                       cedate = NULL){
  result <- lookup_by_state(endpoint = DAILY,
                            bdate = bdate,
                            edate = edate,
                            state.fips = state.fips,
                            param = param,
                            cached = cached,
                            cache_directory = cache_directory,
                            cbdate = cbdate,
                            cedate = cedate)
  return(result)
}

#' Returns daily summary data given a bounding box (lat, long).
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
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' 
#' @return API response containing daily summary data 
#' bounded by lat long coords.
#' 
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' param <- "42401"
#' minlat <- 33.3
#' maxlat <- 33.6
#' minlong <- -87
#' maxlong <- -86.7
#' result <- get_daily_summary_in_bbox(bdate,
#'                                     edate,
#'                                     param,
#'                                     minlat,
#'                                     maxlat,
#'                                     minlong,
#'                                     maxlong)
#' result$Data
#' }
get_daily_summary_in_bbox <- function(bdate,
                                      edate,
                                      param,
                                      minlat,
                                      maxlat,
                                      minlong,
                                      maxlong,
                                      cached = TRUE,
                                      cache_directory = "/cache",
                                      cbdate = NULL,
                                      cedate= NULL){
  result <- lookup_by_bbox(endpoint = DAILY,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           minlat = minlat,
                           maxlat = maxlat,
                           minlong = minlong,
                           maxlong = maxlong,
                           cached = cached,
                           cache_directory = cache_directory,
                           cbdate = cbdate,
                           cedate = cedate)
  return(result)
}

#' Get daily summary data in a Core Based Statistical Area.
#' 
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
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' 
#' @return API response containing daily summary data at the CBSA level.
#' 
#' @examples 
#' \dontrun{
#' bdate <- 20170101
#' edate <- 20170101
#' cbsa <- 16740
#' param <- 42602
#' result <- get_daily_summary_in_cbsa(bdate,
#'                                     edate,
#'                                     cbsa,
#'                                     param)
#' result$Data
#' }
get_daily_summary_in_cbsa <- function(bdate,
                                      edate,
                                      param,
                                      cbsa,
                                      cached = TRUE,
                                      cache_directory = "/cache",
                                      cbdate = NULL,
                                      cedate = NULL){
  result <- lookup_by_cbsa(endpoint = DAILY,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           cbsa = cbsa,
                           cached = cached,
                           cache_directory = cache_directory,
                           cbdate = cbdate,
                           cedate = cedate)
  return(result)
}
