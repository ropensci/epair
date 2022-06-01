#' Get annual summary data at a measurement site.
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
#' @param site Measurement site code.
#' Use get_sites_by_county() if unsure.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' 
#' @return API response containing annual summary data for a site.
#' @examples 
#' \dontrun{
#' bdate <- "20170618"
#' edate <- "20170618"
#' state.fips <- "37"
#' county <- "183"
#' site <- "0014"
#' param <- "44201"
#' result <- get_annual_summary_in_site(bdate,
#'                                      edate,
#'                                      param,
#'                                      state.fips,
#'                                      county,
#'                                      site)
#' result$Data
#' }
get_annual_summary_in_site <- function(bdate,
                               edate,
                               param,
                               state.fips,
                               county,
                               site,
                               cached = TRUE,
                               cache_directory = "/cache",
                               cbdate = NULL,
                               cedate = NULL){
  result <- lookup_by_site(endpoint = ANNUAL,
                           bdate = bdate,
                           edate = edate,
                           state.fips = state.fips,
                           county = county,
                           param = param,
                           site = site,
                           cached = cached,
                           cache_directory = cache_directory,
                           cbdate = cbdate,
                           cedate = cedate)
  return(result)
}

#' Get annual summary data in a county.
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
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' 
#' @return API response containing annual summary data in a county. 
#' 
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' county <- "001"
#' param <- "42401"
#' result <- get_annual_summary_in_county(bdate,
#'                                        edate,
#'                                        state.fips,
#'                                        county,
#'                                        param)
#' result$Data
#' }
get_annual_summary_in_county <- function(bdate,
                                         edate,
                                         state.fips,
                                         county,
                                         param,
                                         cached = TRUE,
                                         cache_directory = "/cache",
                                         cbdate = NULL,
                                         cedate = NULL){
  result <- lookup_by_county(endpoint = ANNUAL,
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

#' Get annual summary data in a state.
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
#' @param cbdate Beginning date of last change to DB. (Optional)
#' @param cedate Ending date of last change to DB. (Optional)
#' 
#' @return API response containing annual summary data for a state.
#' 
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200102"
#' state.fips <- "37"
#' param <- "42401"
#' result <- get_annual_summary_in_state(bdate,
#'                                       edate,
#'                                       state.fips,
#'                                       param)
#' result$Data
#' }
get_annual_summary_in_state <- function(bdate,
                                        edate,
                                        state.fips,
                                        param,
                                        cached = TRUE,
                                        cache_directory = "/cache",
                                        cbdate = NULL,
                                        cedate = NULL){
  result <- lookup_by_state(endpoint = ANNUAL,
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

#' Get annual summary data in a bounding box (lat, long).
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
#' @return API response containing annual summary data in a bounding box.
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
#' result <- get_annual_summary_in_bbox(bdate,
#'                                      edate,
#'                                      param,
#'                                      minlat,
#'                                      maxlat,
#'                                      minlong,
#'                                      maxlong)
#' result$Data
#' }
get_annual_summary_in_bbox <- function(bdate,
                                       edate,
                                       param,
                                       minlat,
                                       maxlat,
                                       minlong,
                                       maxlong,
                                       cached = TRUE,
                                       cache_directory = "/cache",
                                       cbdate = NULL,
                                       cedate = NULL){
  result <- lookup_by_bbox(endpoint = ANNUAL,
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

#' Get annual summary data in a Core Based Statistical Area.
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
#' @return API response containing quarterly summary data at the cbsa level.
#' @examples 
#' \dontrun{
#' bdate <- "20190101"
#' edate <- "20190601"
#' cbsa <- "16740"
#' param <- "42401"
#' result <- get_annual_summary_in_cbsa(bdate, 
#'                                      edate, 
#'                                      param, 
#'                                      cbsa)
#' result$Data
#' }
get_annual_summary_in_cbsa <- function(bdate,
                                       edate,
                                       param,
                                       cbsa,
                                       cached = TRUE,
                                       cache_directory = "/cache",
                                       cbdate = NULL,
                                       cedate = NULL){
  result <- lookup_by_cbsa(endpoint = ANNUAL,
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
