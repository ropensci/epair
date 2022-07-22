epair 1.0.0 (2022-07-22)
=========================

Released to `rOpenSci`. 

### NEW FEATURES

  * Wrapper functions for all services available from the Environmental Protection Agency (EPA) Air Quality API. 
  * Caching for previously made requests. 
  * Comprehensive testing with mocks using `httptest`.
  * CI/CD for automatic pull request checks including test coverage and R-CMD-check. 

### MINOR IMPROVEMENTS

  * Authentication using `.Renviron`.
  * Typo's and formatting for code.
  * Function to get an API key from within `epair`. 
  * Change `print()` to `message()` for expected error types.
  * Redact mock directory paths to be less than 100 bytes for portability.
  * Documentation mismatches fixed. 
  * A contributing file.

### BUG FIXES

  * Failing tests and installation in Windows and Ubuntu. 
  * Problem with `name` argument in `add.variables()`.

### DEPRECATED OR DEFUNCT

  * Removed scraping logic used to make loaded data structures. 

epair 0.1.0 (2020-12-07)
=========================

### NEW FEATURES

  * Loaded in variables to search for and query endpoint and variables in the original Environmental Protection Agency Air Quality API. 
  * General purpose API calling functions with specified variables and endpoints for services.
  * Simple test suites using `testthat`.  
  * Simple scraping logic to make service and variable data structures.