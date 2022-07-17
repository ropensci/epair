httptest::with_mock_dir("state_fips_ok", {
  test_that("Successful status returned", {
    result <- get_state_fips()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("counties_in_state_ok", {
  test_that("Successful status returned", {
    state.fips <- "37"
    result <- get_counties_in_state(state.fips)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("sites_in_county_ok", {
  test_that("Successful status returned", {
    state.fips <- "37"
    county.code <- "001"
    result <- get_sites_in_county(state.fips, county.code)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("cbas_ok", {
  test_that("Successful status returned", {
    result <- get_cbsas()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_parameter_classes() is OK", {
  test_that("Successful status returned", {
    result <- get_parameter_classes()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_parameters_in_class() is OK", {
  test_that("Successful status returned", {
    class <- "AQI POLLUTANTS"
    result <- get_parameters_in_class(class)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("pqaos_ok", {
  test_that("Successful status returned", {
    result <- get_all_pqaos()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("all_mas_ok", {
  test_that("Successful status returned", {
    result <- get_all_mas()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})
