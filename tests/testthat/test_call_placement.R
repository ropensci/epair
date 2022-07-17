httptest::with_mock_dir("raw_return_ok", {
    test_that("place.call.raw returns a response object", {
        endpoint <- "list/states"
        full.url <- create.base.call(endpoint)
        response <- place.call.raw(full.url)
        expect_equal("response", class(response))
    })
})

httptest::with_mock_dir("mod_call_return_ok", {
    test_that("place.call returns a json type (list)", {
        endpoint <- "list/states"
        full.url <- create.base.call(endpoint)
        response <- place.call(full.url)
        expect_equal("list", class(response))
    })
})

httptest::with_mock_dir("simple_call_ok", {
    test_that("Simple call without variables goes through", {
        endpoint <- "list/states"
        response <- perform.call(endpoint)
        status <- response$Header$status
        expect_equal('Success', status)
    })
})

httptest::with_mock_dir("raw_multivariate_ok",{
    test_that("Raw call returns a response object", {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call.raw(endpoint = endpoint,
                                   variables = variable.list)
        found <- result
        exp <- "response"
        expect_equal(exp, class(result))
    })
})

httptest::with_mock_dir("single_variable_ok", {
    test_that("A call with a single additional variable gets made correctly", {
        endpoint <- services$List$Filters$`Counties by State`$Endpoint
        variables <- list("state" = '37')
        result <- perform.call(endpoint = endpoint, variables)
        found <- result$Header$status
        exp <- "Success"
        expect_equal(exp, found)
    })
})

httptest::with_mock_dir("multivariate_ok", {
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

httptest::with_mock_dir("cached_file_deleted_ok",{
    test_that("A cached file that is chosen is deleted", {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call(endpoint = endpoint, variables = variable.list)
        found <- clear.cached(endpoint = endpoint, variables = variable.list)

        expect_equal("Done", found)
    })
})

httptest::with_mock_dir("list_cached_error_ok",{
    test_that(paste("List cached data produces an error when there are",
                    "no cached files found in the directory or no",
                    "directory found"), {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call(endpoint = endpoint, variables = variable.list)
        clear.all.cached()
        expect_error(list.cached.data())
    })
})

httptest::with_mock_dir("list_cached_response_ok",{
    test_that("List cached data produces a character vector reponse", {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call(endpoint = endpoint, variables = variable.list)
        response <- list.cached.data()

        expect_equal("character", class(response))
    })
})

httptest::with_mock_dir("clear_cached_error_ok",{
    test_that(paste("Clear cached produces an error when the file",
                    "or directory is not found"), {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call(endpoint = endpoint, variables = variable.list)
        clear.cached(endpoint = endpoint, variables = variable.list)
        expect_error(clear.cached(endpoint = endpoint,
                                  variables = variable.list))
    })
})

httptest::with_mock_dir("clear_all_error_ok",{
    test_that(paste("Clear all cached produces an error when there",
                    "are no cached files or the directory is not found"), {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call(endpoint = endpoint, variables = variable.list)
        clear.all.cached()
        expect_error(clear.all.cached())
    })
})

httptest::with_mock_dir("retrieve_cache_ok",{
    test_that("Retrieve a previously saved cached call", {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        found <- perform.call(endpoint, variable.list)
        response <- retrieve.cached.call(endpoint, variable.list)
        expect_equal("Success", response$Header$status)
    })
})

httptest::with_mock_dir("save_new_cache_ok",{
    test_that("Save new cached call will save the file in the correct folder", {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '38',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- save.new.cached.call(endpoint, variable.list)
        response <- retrieve.cached.call(endpoint, variable.list)
        expect_equal("Success", response$Header$status)
    })
})

httptest::with_mock_dir("all_cache_deleted_ok",{
    test_that("All cached files are deleted from memory", {
        endpoint <- 'dailyData/byState'
        variable.list <- list("state" = '37',
                              "bdate" = '20200101',
                              "edate" = '20200102',
                              "param" = '44201')
        result <- perform.call(endpoint = endpoint, variables = variable.list)
        found <- clear.all.cached()

        expect_equal("Done", found)
    })
})
