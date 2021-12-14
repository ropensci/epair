httptest::with_mock_dir("get_qq_ca_in_site() is OK", {
    test_that("Status returns successful", {
        bdate <- "20190101"
        edate <- "20190131"
        state.fips <- "01"
        county <- "089"
        param <- "88101"
        site <- "0014"
        result <- get_qa_ca_in_site(bdate = bdate, 
                                     edate = edate, 
                                     state.fips = state.fips, 
                                     county = county, 
                                     param = param, 
                                     site = site)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("get_qa_ca_in_county() is OK", {
    test_that("Status returns successful", {
        bdate <- "20190101"
        edate <- "20190131"
        state.fips <- "01"
        county <- "089"
        param <- "88101"
        result <- get_qa_ca_in_county(bdate = bdate, 
                                       edate = edate, 
                                       state.fips = state.fips, 
                                       county = county,
                                       param = param)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("get_qa_ca_in_state() is OK", {
    test_that("Status returns successful", {
        bdate <- "20190101"
        edate <- "20190131"
        state.fips <- "01"
        param <- "88101"
        result <- get_qa_ca_in_state(bdate = bdate, 
                                      edate = edate, 
                                      state.fips = state.fips, 
                                      param = param)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("get_qa_ca_in_pqao() is OK", {
    test_that("Status returns successful", {
        bdate <- "20190101"
        edate <- "20190131"
        param <- "88101"
        pqao <- "0013"
        result <- get_qa_ca_in_pqao(bdate = bdate,
                                     edate = edate,
                                     param = param,
                                     pqao = pqao)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("get_qa_ca_in_agency() is OK", {
    test_that("Status returns successful", {
        bdate <- "20190101"
        edate <- "20190131"
        param <- "88101"
        agency <- "0013"
        result <- get_qa_ca_in_agency(bdate = bdate, 
                                       edate = edate, 
                                       param = param, 
                                       agency = agency)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})