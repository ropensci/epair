request.sanitizer <- function (request) {
  require(magrittr, quietly=TRUE)
  request %>%
    gsub_request("https\\://aqs.epa.gov/data/api/", "aqs_api/", fixed=TRUE)
    gsub_request(Sys.getenv("aqs_email"), "fake_aqs_email@domain.com") %>%
    gsub_request(Sys.getenv("aqs_api_key"), "fake_aqs_api_key")
}

set_requester(request.sanitizer)