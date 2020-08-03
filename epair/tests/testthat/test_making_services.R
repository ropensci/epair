context("Services variable is setup properly")
library(epair)
library(rvest)

## TODO documentation must be present to explain the html_table.xml_node() issue

## TODO Place skip() since these will be using API tables

test_that("A unique filter is being retrieved from a table containing filters", {
  api_tbls <- epair:::get.all.tables()
  monitors_service <- api_tbls[[6]]
  exp_filters <- c("By Site", "By County", "By State", "By Box", "By CBSA")
  found_filters <- epair:::get.unique.filters(monitors_service)
  expect_equal(exp_filters, found_filters)
})


test_that("A unique filter is being retrieved from a table not containing filters", {
  api_tbls <- epair:::get.all.tables()
  descriptions <- api_tbls[[1]]
  exp_filters <- "This table doesn't contain filters!"
  found_filters <- epair:::get.unique.filters(descriptions)
  expect_equal(exp_filters, found_filters)
})

test_that("A single service table got transformed into a list of expected format", {
  service <- "Daily Data"
  filter <- "By Box"
  endpoint <- "dailyData/byBox"
  required_variables <- 
  daily_data <- data.frame()
  #' setup.service(single)
  
  
})