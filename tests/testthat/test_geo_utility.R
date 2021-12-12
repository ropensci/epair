httptest::with_mock_dir("lookup_by_cbsa() is OK", {
  test_that("Status returns successful", {
    bdate <- "20200101"
    edate <- "20200102"
    cbsa <- "16740"
    param <- "42401"
    result <- lookup_by_cbsa(endpoint = MONITORS, 
                             bdate = bdate, 
                             edate = edate, 
                             param = param, 
                             cbsa = cbsa)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("lookup_by_bbox() is OK", {
  test_that("Status returns successful", {
    bdate <- "20200101"
    edate <- "20200102"
    param <- "42401"
    minlat <- 33.3
    maxlat <- 33.6
    minlong <- -87
    maxlong <- -86.7
    result <- lookup_by_bbox(endpoint = MONITORS, 
                            bdate = bdate, 
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

httptest::with_mock_dir("lookup_by_state() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    param <- "42401"
    result <- lookup_by_state(MONITORS, bdate = bdate, 
                                        edate = edate, 
                                        state = state.fips,
                                        param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("lookup_by_county() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    result <- lookup_by_county(MONITORS, bdate = bdate, 
                                         edate = edate, 
                                         state = state.fips, 
                                         county = county,
                                         param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("lookup_by_site() is OK", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    site <- "0007"
    result <- lookup_by_site(MONITORS, bdate = bdate, 
                                       edate = edate, 
                                       state = state.fips, 
                                       county = county,
                                       param = param,
                                       site = site)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})
