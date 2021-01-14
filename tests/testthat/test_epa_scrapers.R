test_that("An endpoint is present in the string based on EPA table structure", {
  test_str <- "list/states?"
  exp <- FALSE
  found <- epair:::non.endpoint.checker(test_str)
  expect_equal(exp, found)
  
  test_str <- "Example usage of service"
  exp <- TRUE
  found <- epair:::non.endpoint.checker(test_str)
  expect_equal(exp, found)
})

test_that("Variables data in package matches data acquired from site", {
  skip("Test uses web scraping method")
  vars <- epair:::get.variables()
  expect_equal(vars, variables)
})

test_that("Services data in package matches data acquired from site", {
  skip("Test uses web scraping method")
  services_call <- epair:::get.services()
  expect_equal(services, services_call)
})

test_that("Service names data in package matches data acquired from site", {
  skip("Test uses web scraping method")
  service_names_call <- epair:::get.service.names()
  expect_equal(service.names, service_names_call)
})

test_that("Endpoints data in package matches data acquired from site", {
  skip("Test uses web scraping method")
  endpoints_call <- epair:::get.endpoints()
  expect_equal(endpoints, endpoints_call)
})