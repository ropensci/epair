credential.redactor <- function (response) {
  require(magrittr, quietly=TRUE)
    response %>%
      gsub_response("https://aqs.epa.gov/data/api/", "") %>%
      gsub_response("qaAnnualPerformanceEvaluations", "qaAPE") %>%
      gsub_response(Sys.getenv("aqs_email"), "fake_aqs_email@domain.com") %>%
      gsub_response(Sys.getenv("aqs_api_key"), "fake_aqs_api_key")
}


set_redactor(credential.redactor)
