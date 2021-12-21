httptest::with_mock_dir("get_daily_summary_in_site() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    site <- "0007"
    result <- get_daily_summary_in_site(bdate = bdate,
                                        edate = edate,
                                        state.fips = state.fips,
                                        county = county,
                                        param = param,
                                        site = site)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_daily_summary_in_county() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    result <- get_daily_summary_in_county(bdate = bdate,
                                          edate = edate,
                                          state.fips = state.fips,
                                          county = county,
                                          param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_daily_summary_in_state() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    param <- "42401"
    result <- get_daily_summary_in_state(bdate = bdate,
                                         edate = edate,
                                         state.fips = state.fips,
                                         param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_daily_summary_in_bbox() is OK", {
  test_that("Status returns successful", {
    bdate <- "20200101"
    edate <- "20200102"
    param <- "42401"
    minlat <- 33.3
    maxlat <- 33.6
    minlong <- -87
    maxlong <- -86.7
    result <- get_daily_summary_in_bbox(bdate = bdate,
                                        edate = edate,
                                        param = param,
                                        minlat = minlat,
                                        maxlat = maxlat,
                                        minlong = minlong,
                                        maxlong = maxlong)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_daily_summary_in_cbsa() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160103"
    cbsa <- "16740"
    param <- "42401"
    result <- get_daily_summary_in_cbsa(bdate = bdate,
                                        edate = edate,
                                        cbsa = cbsa,
                                        param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})
