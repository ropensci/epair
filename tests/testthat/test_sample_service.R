httptest::with_mock_dir("get_samples_in_bbox() is OK", {
  test_that("status returns successful in regular call", {
    bdate <- "20200101"
    edate <- "20200102"
    param <- "42401"
    minlat <- 33.3
    maxlat <- 33.6
    minlong <- -87
    maxlong <- -86.7
    result <- get_samples_in_bbox(bdate = bdate,
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

httptest::with_mock_dir("get_samples_in_cbsa() is OK", {
  test_that("Status returns successful in regular call", {
    bdate <- "20200101"
    edate <- "20200102"
    cbsa <- "16740"
    param <- "42401"
    result <- get_samples_in_cbsa(bdate = bdate,
                                  edate = edate,
                                  param = param,
                                  cbsa = cbsa)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_samples_in_county() is OK", {
  test_that("Status returns successful in regular call", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    result <- get_samples_in_county(bdate = bdate,
                                    edate = edate,
                                    param = param,
                                    state.fips = state.fips,
                                    county = county)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_samples_in_state() is OK", {
  test_that("Status returns successful in regular call", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    param <- "42401"
    result <- get_samples_in_state(bdate = bdate, 
                                   edate = edate, 
                                   param = param, 
                                   state.fips = state.fips)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_samples_in_site() is OK", {
  test_that("Status returns successful in regular call", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    site <- "0007"
    result <- get_samples_in_site(bdate = bdate, 
                                  edate = edate, 
                                  param = param, 
                                  state.fips = state.fips,
                                  county = county,
                                  site = site)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})
