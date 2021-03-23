httptest::with_mock_dir("Non-existant endpoint", { 
  test_that("Non-existant endpoint results in messages for call placements", {
    endpoint <- "list/countries"
    response <- perform.call.raw(endpoint)
    status <- response$status_code
    testthat::expect_equal(422, status)
  })
})

httptest::with_mock_dir("Add single variable", {  
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
