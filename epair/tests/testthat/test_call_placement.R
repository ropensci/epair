context("Ensure bad endpoints are caught in a general call")
library(epair)
library(testthat)

test_that("Non-existant endpoints result in messages for call placements", {
  skip("Test uses API calling method")
  endpoint <- "list/countries"
  response <- perform.call.raw(endpoint)
  status <- response$status_code
  expect_equal(422, status)
  
  endpoint <- "list/countries"
  response <- perform.call(endpoint)
  exp <- "No matching service was found, please check spelling and case. Link to API Documentation: https://aqs.epa.gov/aqsweb/documents/data_api.html"
  expect_equal(exp, response)
})

