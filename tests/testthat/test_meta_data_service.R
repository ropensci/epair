httptest::with_mock_dir("get_revision_history() is OK", {
  test_that("Successful status returned", {
    result <- get_revision_history()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_issues() is OK", {
  test_that("Successful status returned", {
    result <- get_known_issues()
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

httptest::with_mock_dir("get_fields_by_service() is OK", {
  test_that("Successful status returned for present service", {
    service <- "list"
    result <- get_fields_by_service(service)
    found.status <- result$Header$status
    exp.status <- "Success"
    expect_equal(exp.status, found.status)
  })
})

