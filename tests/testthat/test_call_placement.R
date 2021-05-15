httptest::with_mock_dir("place.call.raw return is correct", {
  test_that("place.call.raw returns a response object", {
    endpoint <- "list/states"
    full.url <- epair:::create.base.call(endpoint)
    response <- epair:::place.call.raw(full.url)
    expect_equal("response", class(response))
  })
})

httptest::with_mock_dir("place.call return is correct", {
  test_that("place.call returns a json type (list)", {
    endpoint <- "list/states"
    full.url <- epair:::create.base.call(endpoint)
    response <- epair:::place.call(full.url)
    expect_equal("list", class(response))
  })
})

httptest::with_mock_dir("Non-variable call made correctly", {
  test_that("Simple call without variables goes through", {
    endpoint <- "list/states"
    response <- perform.call(endpoint)
    status <- response$Header$status
    testthat::expect_equal('Success', status)
  })
})

httptest::with_mock_dir("Non-existant endpoint", { 
  test_that("Non-existant endpoint results in messages for call placements", {
    endpoint <- "list/countries"
    response <- perform.call.raw(endpoint)
    status <- response$status_code
    testthat::expect_equal(422, status)
  })
})

httptest::with_mock_dir("Raw call for multiple variables returns expected result",{
  test_that("Raw call returns a response object", {
    endpoint <- 'dailyData/byState'
    variable.list <- list("state" = '37', 
                          "bdate" = '20200101', 
                          "edate" = '20200102', 
                          "param" = '44201')
    result <- perform.call.raw(endpoint = endpoint, variables = variable.list)
    found <- result
    exp <- "response"
    expect_equal(exp, class(result))
  })
})

httptest::with_mock_dir("Single variable call", {
  test_that("A call with a single additional variable gets made correctly", {
    endpoint <- services$List$Filters$`Counties by State`$Endpoint
    variables <- list("state" = '37')
    result <- perform.call(endpoint = endpoint, variables)  
    found <- result$Header$status
    exp <- "Success"
    expect_equal(exp, found)
  })
})


httptest::with_mock_dir("Add multiple variables" , {  
  test_that("A call with multiple variables gets made correctly", {
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
})
