#' Get sample data in the transaction format at
#' a site.
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
#' @return API response containing all sample data in submission format.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200331"
#' state.fips <- "01"
#' county <- "003"
#' param <- "44201"
#' site <- "0010"
#' result <- get_tf_sample_in_site(bdate,
#'                                 edate,
#'                                 state.fips,
#'                                 county,
#'                                 param,
#'                                 site)
#' result$Data
#' } 


get_tf_sample_in_site <- function(bdate,
                                  edate,
                                  state.fips,
                                  county,
                                  param,
                                  site,
                                  cached = TRUE,
                                  cache_directory = "/cache"){
    result <- lookup_by_site(endpoint = TF_SAMPLE,
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

#' Get sample data in the transaction format in a county.
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
#' @return API response containing all sample data in submission format.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200331"
#' state.fips <- "01"
#' county <- "003"
#' param <- "44201"
#' result <- get_tf_sample_in_county(bdate, edate, state.fips, county, param)
#' result$Data
#' }
get_tf_sample_in_county <- function(bdate, 
                                    edate, 
                                    state.fips, 
                                    county, 
                                    param,
                                    cached = TRUE,
                                    cache_directory = "/cache"){
    result <- lookup_by_county(endpoint = TF_SAMPLE, 
                               bdate = bdate, 
                               edate = edate, 
                               state.fips = state.fips, 
                               county = county, 
                               param = param,
                               cached = cached,
                               cache_directory = cache_directory)
    return(result)
}

#' Get sample data in the transaction format in a state.
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
#' @return API response containing all sample data in submission format.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200331"
#' state.fips <- "01"
#' param <- "44201"
#' result <- get_tf_sample_in_state(bdate, edate, state.fips, param)
#' result$Data
#' }
get_tf_sample_in_state <- function(bdate, 
                                   edate, 
                                   state.fips, 
                                   param,
                                   cached = TRUE,
                                   cache_directory = "/cache"){
    result <- lookup_by_state(endpoint = TF_SAMPLE,
                              bdate = bdate,
                              edate = edate,
                              state.fips = state.fips,
                              param = param,
                              cached = cached,
                              cache_directory = cache_directory)
    return(result)
}

#' Get sample data in the transaction format for a monitoring agency.
#' @export
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param param Pollutant parameter that site is measuring.
#' @param agency The monitoring agency.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @return API response containing all sample data in submission format.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20200331"
#' state.fips <- "01"
#' param <- "44201"
#' agency <- "0013"
#' result <- get_tf_sample_in_agency(bdate, 
#'                               edate, 
#'                               param, 
#'                               agency)
#' result$Data
#' }
get_tf_sample_in_agency <-  function(bdate, 
                                  edate, 
                                  param, 
                                  agency,
                                  cached = TRUE,
                                  cache_directory = "/cache"){
    result <- lookup_by_ma(endpoint = TF_SAMPLE,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           agency = agency,
                           cached = cached,
                           cache_directory = cache_directory)
    return(result)
}


