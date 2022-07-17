httptest::with_mock_dir("quarterly_summary_in_site_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160601"
    state.fips <- "37"
    county <- "183"
    site <- "0014"
    param <- "42401"
    result <- get_quarterly_summary_in_site(bdate = bdate, 
                                            edate = edate, 
                                            state.fips = state.fips, 
                                            county = county, 
                                            param = param, 
                                            site = site)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(found.status, exp.status)
  })
})

httptest::with_mock_dir("quarterly_summary_in_county_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160601"
    state.fips <- "37"
    county <- "183"
    param <- "42401"
    result <- get_quarterly_summary_in_county(bdate = bdate, 
                                              edate = edate, 
                                              state.fips = state.fips, 
                                              county = county, 
                                              param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(found.status, exp.status)
  })
})

httptest::with_mock_dir("quarterly_summary_in_state_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160601"
    state.fips <- "37"
    param <- "42401"
    result <- get_quarterly_summary_in_state(bdate = bdate, 
                                             edate = edate, 
                                             state.fips = state.fips,
                                             param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(found.status, exp.status)
  })
})

httptest::with_mock_dir("quarterly_summary_in_bbox_ok", {
  test_that("Status returns successful", {
    bdate <- "20200101"
    edate <- "20200102"
    param <- "42401"
    minlat <- 33.3
    maxlat <- 33.6
    minlong <- -87
    maxlong <- -86.7
    result <- get_quarterly_summary_in_bbox(bdate,
                                            edate,
                                            param,
                                            minlat,
                                            maxlat,
                                            minlong,
                                            maxlong)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(found.status, exp.status)
  })
})

httptest::with_mock_dir("quarterly_summary_in_cbsa_ok", {
  test_that("Status returns successful", {
    bdate <- "20190101"
    edate <- "20190601"
    cbsa <- "16740"
    param <- "42401"
    result <- get_quarterly_summary_in_cbsa(bdate, 
                                             edate, 
                                             param, 
                                             cbsa)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(found.status, exp.status)
  })
})
