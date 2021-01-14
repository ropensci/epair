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

test_that("Spaces can be passed into calls", {
  skip("Test uses API calling method")
  endpoint <- "list/parametersByClass"
  pc <- "AQI POLLUTANTS"       
  result <- perform.call(endpoint, pc)
  found <- result$Header$status
  exp <- "Success"
  expect_equal(exp, found)
})

test_that("A call with a single additional variable gets made correctly", {
  skip("Test uses API calling method")
  
  # User goes with first method for passing in a single additional variable
  endpoint <- services$List$Filters$`Counties by State`$Endpoint
  state.code <- '37'
  result <- perform.call(endpoint = endpoint, variables = state.code, name = "state")
  found <- result$Header$status
  exp <- "Success"
  expect_equal(exp, found)
  
  # User goes with second method for passing in a single additional variable
  endpoint <- services$List$Filters$`Counties by State`$Endpoint
  state <- '37'
  result <- perform.call(endpoint = endpoint, variables = state)
  found <- result$Header$status
  exp <- "Success"
  expect_equal(exp, found)
})

test_that("A call with multiple variables gets made correctly", {
  skip("Test uses API calling method")
  # User must setup authentication before making call, see create.authentication()
  
  # User goes with first method for passing in multiple variables
  endpoint <- 'dailyData/byState'
  variable.list <- list('37','20200101','20200102','44201')
  result <- perform.call(endpoint = endpoint, 
                         variables = variable.list, 
                         name = list("state", "bdate", "edate", "param"))
  found <- result$Header$status
  exp <- "Success"
  expect_equal(exp, found)
  
  # User goes with second method for passing in multiple variables
  endpoint <- 'dailyData/byState'
  variable.list <- list("state" = '37', 
                        "bdate" = '20200101', 
                        "edate" = '20200102', 
                        "param" = '44201')
  result <- perform.call(endpoint = endpoint, variables = variable.list)
  found <- result$Header$status
  exp <- "Success"
  expect_equal(exp, found)
})