aqs_email = Sys.getenv("API_EMAIL")
aqs_api_key = Sys.getenv("API_KEY")
Sys.setenv('aqs_email' = aqs_email)
Sys.setenv('aqs_api_key' = aqs_api_key)

source("R/call_placement.R")
source("R/call_construction.R")
source("R/data_transforms.R")
source("R/Datasets.R")
load("data/services.RData")

testthat::test_file("tests/testthat/live_test_calls.R", "fail")
