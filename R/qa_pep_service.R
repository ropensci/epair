#' Get quality assurance PEP audit data at
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
#' @return API response containing operational information
#' about the quality assurance PEP audit data.
#' @examples 
#' \dontrun{
#' bdate <- "20180101"
#' edate <- "20181231"
#' state.fips <- "01"
#' county <- "089"
#' param <- "88101"
#' site <- "0014"
#' result <- get_qa_pep_in_site(bdate, edate, state.fips, county, param, site)
#' result$Data
#' } 
get_qa_pep_in_site <- function(bdate, 
                               edate, 
                               state.fips, 
                               county, 
                               param, 
                               site,
                               cached = TRUE,
                               cache_directory = "/cache"){
    result <- lookup_by_site(endpoint = QA_PEP,
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

#' Get quality assurance PEP audit data in a county.
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
#' about the quality assurance PEP audit data.
#' @examples 
#' \dontrun{
#' bdate <- "20180101"
#' edate <- "20181231"
#' state.fips <- "01"
#' county <- "089"
#' param <- "88101"
#' result <- get_qa_pep_in_county(bdate, edate, state.fips, county, param)
#' result$Data
#' }
get_qa_pep_in_county <- function(bdate, 
                                 edate, 
                                 state.fips, 
                                 county, 
                                 param,
                                 cached = TRUE,
                                 cache_directory = "/cache"){
    result <- lookup_by_county(endpoint = QA_PEP, 
                               bdate = bdate, 
                               edate = edate, 
                               state.fips = state.fips, 
                               county = county, 
                               param = param,
                               cached = cached,
                               cache_directory = cache_directory)
    return(result)
}

#' Get quality assurance PEP audit data in a state.
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
#' about the quality assurance PEP audit data.
#' @examples 
#' \dontrun{
#' bdate <- "20180101"
#' edate <- "20181231"
#' state.fips <- "01"
#' param <- "88101"
#' result <- get_qa_pep_in_state(bdate, edate, state.fips, param)
#' result$Data
#' }
get_qa_pep_in_state <- function(bdate, 
                                edate, 
                                state.fips, 
                                param,
                                cached = TRUE,
                                cache_directory = "/cache"){
    result <- lookup_by_state(endpoint = QA_PEP,
                              bdate = bdate,
                              edate = edate,
                              state.fips = state.fips,
                              param = param,
                              cached = cached,
                              cache_directory = cache_directory)
    return(result)
}

#' Get quality assurance PEP audit data
#' for a primary quality assurance
#' organization.
#' @export
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param pqao An encoding for a primary quality assurance organization.
#' If unsure, use get_all_pqaos().
#' @param param Pollutant parameter that site is measuring.
#' @param cached TRUE or FALSE specifying if the data from the call is to 
#' be cached. Default: TRUE. (Optional)
#' @param cache_directory Place inside user-level cache directory to store 
#' the cached data. Default: "/cache". (Optional)
#' @return API response containing operational information
#' about the quality assurance PEP audit data.
#' @examples 
#' \dontrun{
#' bdate <- "20180101"
#' edate <- "20181231"
#' param <- "88101"
#' pqao <- "0013"
#' result <- get_qa_pep_in_pqao(bdate, edate, param, pqao)
#' result$Data
#' }
get_qa_pep_in_pqao <- function(bdate, 
                               edate, 
                               param, 
                               pqao,
                               cached = TRUE,
                               cache_directory = "/cache"){
    result <- lookup_by_pqao(endpoint = QA_PEP,
                             bdate = bdate,
                             edate = edate,
                             param = param,
                             pqao = pqao,
                             cached = cached,
                             cache_directory = cache_directory)
    return(result)
}

#' Get quality assurance PEP audit data for a monitoring agency.
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
#' @return API response containing operational information
#' about the quality assurance PEP audit data.
#' @examples 
#' \dontrun{
#' bdate <- "20180101"
#' edate <- "20181231"
#' param <- "88101"
#' agency <- "0013"
#' result <- get_qa_pep_in_agency(bdate, 
#'                               edate, 
#'                               param, 
#'                               agency)
#' result$Data
#' }
get_qa_pep_in_agency <-  function(bdate, 
                                  edate, 
                                  param, 
                                  agency,
                                  cached = TRUE,
                                  cache_directory = "/cache"){
    result <- lookup_by_ma(endpoint = QA_PEP,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           agency = agency,
                           cached = cached,
                           cache_directory = cache_directory)
    return(result)
}


