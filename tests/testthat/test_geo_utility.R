httptest::with_mock_dir("geo_util_change_lookup_by_cbsa_ok", {
  test_that("Status returns successful in regular call", {
    bdate <- "20200101"
    edate <- "20200102"
    cbdate <- "20200101"
    cedate <- "20201231"
    cbsa <- "16740"
    param <- "42401"
    result <- lookup_by_cbsa(endpoint = SAMPLE, 
                             bdate = bdate, 
                             edate = edate, 
                             param = param, 
                             cbsa = cbsa,
                             cbdate = cbdate,
                             cedate = cedate)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_regular_lookup_by_cbsa_ok", {
  test_that("Status returns successful in regular call", {
    bdate <- "20200101"
    edate <- "20200102"
    cbsa <- "16740"
    param <- "42401"
    result <- lookup_by_cbsa(endpoint = SAMPLE, 
                             bdate = bdate, 
                             edate = edate, 
                             param = param, 
                             cbsa = cbsa)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_duration_lookup_by_cbsa_ok", {
  test_that("Status returns successful in duration call", {
    bdate <- "20200101"
    edate <- "20200102"
    cbsa <- "16740"
    param <- "42401"
    duration <- "1"
    result <- lookup_by_cbsa(endpoint = SAMPLE, 
                             bdate = bdate, 
                             edate = edate, 
                             param = param, 
                             cbsa = cbsa,
                             duration = duration)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})


httptest::with_mock_dir("geo_util_duration_lookup_by_bbox_ok", {
  test_that("Status returns successful", {
    bdate <- "20200101"
    edate <- "20200102"
    param <- "42401"
    minlat <- 33.3
    maxlat <- 33.6
    minlong <- -87
    maxlong <- -86.7
    duration <- 1
    result <- lookup_by_bbox(endpoint = SAMPLE, 
                             bdate = bdate, 
                             edate = edate, 
                             param = param, 
                             minlat = minlat, 
                             maxlat = maxlat, 
                             minlong = minlong, 
                             maxlong = maxlong,
                             duration = 1)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_change_lookup_by_bbox_ok", {
  test_that("Status returns successful", {
    bdate <- "20200101"
    edate <- "20200102"
    param <- "42401"
    minlat <- 33.3
    maxlat <- 33.6
    minlong <- -87
    maxlong <- -86.7
    cbdate <- "20200101"
    cedate <- "20201231"
    result <- lookup_by_bbox(endpoint = MONITORS, 
                             bdate = bdate, 
                             edate = edate, 
                             param = param, 
                             minlat = minlat, 
                             maxlat = maxlat, 
                             minlong = minlong, 
                             maxlong = maxlong,
                             cbdate = cbdate,
                             cedate = cedate)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_regular_lookup_by_bbox_ok", {
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

httptest::with_mock_dir("geo_util_change_lookup_by_state_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    param <- "42401"
    cbdate <- "20200101"
    cedate <- "20201231"
    result <- lookup_by_state(endpoint = SAMPLE,
                              bdate = bdate, 
                              edate = edate, 
                              state = state.fips,
                              param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_duration_lookup_by_state_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    param <- "42401"
    duration <- 1
    result <- lookup_by_state(endpoint = SAMPLE, 
                              bdate = bdate, 
                              edate = edate, 
                              state = state.fips,
                              param = param,
                              duration = duration)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_regular_lookup_by_state_ok", {
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

httptest::with_mock_dir("geo_util_change_lookup_by_county_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    cbdate <- "20200101"
    cedate <- "20201231"
    result <- lookup_by_county(endpoint = MONITORS, 
                               bdate = bdate, 
                               edate = edate, 
                               state = state.fips, 
                               county = county,
                               param = param,
                               cbdate = cbdate,
                               cedate = cedate)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_regular_lookup_by_county_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    result <- lookup_by_county(endpoint = MONITORS, 
                               bdate = bdate, 
                               edate = edate, 
                               state = state.fips, 
                               county = county,
                               param = param)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_duration_lookup_by_county_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    duration <- 1
    result <- lookup_by_county(endpoint = SAMPLE, 
                               bdate = bdate, 
                               edate = edate, 
                               state = state.fips, 
                               county = county,
                               param = param,
                               duration = duration)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_change_lookup_by_site_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    site <- "0007"
    cbdate <- "20200101"
    cedate <- "20201231"
    result <- lookup_by_site(endpoint = MONITORS, 
                             bdate = bdate, 
                             edate = edate, 
                             state = state.fips, 
                             county = county,
                             param = param,
                             site = site,
                             cbdate = cbdate,
                             cedate = cedate)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_duration_lookup_by_site_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    site <- "0007"
    duration <- 1
    result <- lookup_by_site(endpoint = SAMPLE, 
                             bdate = bdate, 
                             edate = edate, 
                             state = state.fips, 
                             county = county,
                             param = param,
                             site = site,
                             duration = duration)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("geo_util_regular_lookup_by_site_ok", {
  test_that("Status returns successful", {
    bdate <- "20160101"
    edate <- "20160102"
    state.fips <- "15"
    county <- "001"
    param <- "42401"
    site <- "0007"
    result <- lookup_by_site(endpoint = MONITORS, 
                             bdate = bdate, 
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

httptest::with_mock_dir("geo_util_regular_lookup_by_pqao_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        param <- "44201"
        pqao <- "0013"
        result <- lookup_by_pqao(endpoint = QA_APE, 
                                 bdate = bdate, 
                                 edate = edate, 
                                 param = param,
                                 pqao = pqao)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("geo_util_regular_lookup_by_ma_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        param <- "44201"
        agency <- "0013"
            result <- lookup_by_ma(endpoint = QA_APE, 
                                 bdate = bdate, 
                                 edate = edate, 
                                 param = param,
                                 agency = agency)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})
