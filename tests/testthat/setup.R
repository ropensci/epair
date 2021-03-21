library(httptest)

if (!nzchar(Sys.getenv("aqs_email"))) {
  Sys.setenv(aqs_email = "fake_aqs_email")
}

if (!nzchar(Sys.getenv("aqs_api_key"))) {
  Sys.setenv(aqs_api_key = "fake_api_key_value")
}
