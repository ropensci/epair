test_that("A unique filter is being retrieved from a table containing filters", {
  skip("Test uses web scraping method")
  api_tbls <- epair:::get.all.tables()
  monitors_service <- api_tbls[[6]]
  exp_filters <- c("By Site", "By County", "By State", "By Box", "By CBSA")
  found_filters <- epair:::get.unique.filters(monitors_service)
  expect_equal(exp_filters, found_filters)
})


test_that("A unique filter is being retrieved from a table not containing filters", {
  skip("Test uses web scraping method")
  api_tbls <- epair:::get.all.tables()
  descriptions <- api_tbls[[1]]
  exp_filters <- "This table doesn't contain filters!"
  found_filters <- epair:::get.unique.filters(descriptions)
  expect_equal(exp_filters, found_filters)
})

test_that("A single service table got transformed into a list of expected format", {
  Service <- "Daily Data"
  Filter <- "By Box"
  Endpoint <- "dailyData/byBox"
  daily_data <- data.frame(Service, 
                           Filter, 
                           Endpoint, 
                           stringsAsFactors = FALSE)
  daily_data$`Required Variables` <- "email, key, bounding box"
  daily_data$`Optional Variables` <- "options"
  found_list <- epair:::setup.service(daily_data)
  
  exp_list <- list()
  exp_list$`Daily Data`$Filters$`By Box`$Endpoint <- "dailyData/byBox"
  exp_list$`Daily Data`$Filters$`By Box`$RequiredVariables <- daily_data$`Required Variables`
  exp_list$`Daily Data`$Filters$`By Box`$OptionalVariables <- daily_data$`Optional Variables`
  exp_list$`Daily Data`$Filters$`By Box`$Example <- daily_data$Service[2]
  
  expect_equal(found_list, exp_list)
})
