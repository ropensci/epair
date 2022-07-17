httptest::with_mock_dir("tf_qa_ape_in_site_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        state.fips <- "01"
        county <- "003"
        param <- "44201"
        site <- "0010"
        result <- get_tf_qa_ape_in_site(bdate = bdate, 
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

httptest::with_mock_dir("tf_qa_ape_in_county_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        state.fips <- "01"
        county <- "003"
        param <- "44201"
        result <- get_tf_qa_ape_in_county(bdate = bdate, 
                                       edate = edate, 
                                       state.fips = state.fips, 
                                       county = county,
                                       param = param)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("tf_qa_ape_in_state_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        state.fips <- "01"
        param <- "44201"
        result <- get_tf_qa_ape_in_state(bdate = bdate, 
                                      edate = edate, 
                                      state.fips = state.fips, 
                                      param = param)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("tf_qa_ape_in_pqao_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        pqao <- "0013"
        param <- "44201"
        result <- get_tf_qa_ape_in_pqao(bdate = bdate,
                                     edate = edate,
                                     param = param,
                                     pqao = pqao)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})

httptest::with_mock_dir("tf_qa_ape_in_agency_ok", {
    test_that("Status returns successful", {
        bdate <- "20200101"
        edate <- "20201231"
        param <- "44201"
        agency <- "0013"
        result <- get_tf_qa_ape_in_agency(bdate = bdate, 
                                       edate = edate, 
                                       param = param, 
                                       agency = agency)
        found.status <- result$Header$status
        exp.status <- "Success"
        expect_equal(exp.status, found.status)
    })
})