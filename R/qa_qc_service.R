#' Get quality assurance one point quality control data at
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
#' @return API response containing operational information
#' about the quality assurance one point quality control data.
#' @examples 
#' \dontrun{
#' bdate <- "20200101"
#' edate <- "20201231"
#' state.fips <- "01"
#' county <- "003"
#' param <- "44201"
#' site <- "0010"
#' result <- get_qa_qc_in_site(bdate, edate, state.fips, county, param, site)
#' result$Data
#' } 
get_qa_qc_in_site <- function(bdate, edate, state.fips, county, param, site){
    result <- lookup_by_site(endpoint = QA_QC,
                             bdate = bdate,
                             edate = edate,
                             state.fips = state.fips,
                             county = county,
                             param = param,
                             site = site)
    return(result)
}

#' Get quality assurance annual one point quality control data
#' in a county.
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
#' @return API response containing operational information
#' about the quality assurance one point quality control data.
#' @examples 
#' \dontrun{
#' bdate <- "20170101"
#' edate <- "20171231"
#' state.fips <- "01"
#' county <- "003"
#' param <- "44201"
#' result <- get_qa_qc_in_county(bdate, edate, state.fips, county, param)
#' result$Data
#' }
get_qa_qc_in_county <- function(bdate, edate, state.fips, county, param){
    result <- lookup_by_county(endpoint = QA_QC, 
                               bdate = bdate, 
                               edate = edate, 
                               state.fips = state.fips, 
                               county = county, 
                               param = param)
    return(result)
}

#' Get quality assurance one point quality control data in a state.
#' 
#' @export
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param state.fips State FIPS code.
#' Use get_state_fips() if unsure.
#' @param param Pollutant parameter that site is measuring.
#' @return API response containing operational information
#' about the quality assurance one point quality control data.
#' @examples 
#' \dontrun{
#' bdate <- "20170101"
#' edate <- "20171231"
#' state.fips <- "01"
#' param <- "44201"
#' result <- get_qa_qc_in_state(bdate, edate, state.fips, param)
#' result$Data
#' }
get_qa_qc_in_state <- function(bdate, edate, state.fips, param){
    result <- lookup_by_state(endpoint = QA_QC,
                              bdate = bdate,
                              edate = edate,
                              state.fips = state.fips,
                              param = param)
    return(result)
}

#' Get quality assurance one point quality control data
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
#' @return API response containing operational information
#' about the quality assurance one point quality control data.
#' @examples 
#' \dontrun{
#' bdate <- "20170101"
#' edate <- "20171231"
#' pqao <- "0013"
#' param <- "44201"
#' result <- get_qa_qc_in_pqao(bdate, edate, param, pqao)
#' result$Data
#' }
get_qa_qc_in_pqao <- function(bdate, edate, param, pqao){
    result <- lookup_by_pqao(endpoint = QA_QC,
                             bdate = bdate,
                             edate = edate,
                             param = param,
                             pqao = pqao)
    return(result)
}

#' Get quality assurance one point quality control data for a monitoring agency.
#' @export
#' @param bdate Beginning date to check.
#' Year, month, day format.
#' @param edate Ending date to check.
#' Year, month, day format.
#' @param param Pollutant parameter that site is measuring.
#' @param mas An encoding for a monitoring agency. 
#' If unsure, use get_all_mas().
#' @return API response containing operational information
#' about the quality assurance one point quality control data.
#' @examples 
#' \dontrun{
#' bdate <- "20170101"
#' edate <- "20171231"
#' param <- "44201"
#' agency <- "0013"
#' result <- get_qa_qc_in_agency(bdate, 
#'                               edate, 
#'                               param, 
#'                               agency)
#' result$Data
#' }
get_qa_qc_in_agency <-  function(bdate, 
                                  edate, 
                                  param, 
                                  agency){
    result <- lookup_by_ma(endpoint = QA_QC,
                           bdate = bdate,
                           edate = edate,
                           param = param,
                           agency = agency)
    return(result)
}


