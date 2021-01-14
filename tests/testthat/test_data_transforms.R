test_that("Characters get replaced correctly in a data frame", {
  df <- data.frame(c("1", "2", "3", "4"))
  found_df <- string.replacer(df, "1", "One")
  exp_df <- data.frame(c("One", "2", "3", "4"))
  expect_equal(found_df[1,], exp_df[1,])
})

test_that("Char gets replaced in a list", {
  og_list <- list("Table entry 1" = "\t Some text from the table",
                  "Table entry 2" = 'Some more text \t from the table')
  found_list <- list.string.replacer(og_list, "\t", "")
  exp_list <- list("Table entry 1" = " Some text from the table",
                   "Table entry 2" = 'Some more text  from the table')
  expect_equal(found_list, exp_list)
})

test_that("Extra chars in data frames get removed", {
  service <- c("Sign up")
  description <- c("Email will\r\n\t\t\t\t\t\t\t be sent to the registered address from aqsdatamart@epa.gov.")
  og_table <- data.frame(service, description)
  found_df <- remove.escapes.spaces(og_table)
  description <- c("Email will be sent to the registered address from aqsdatamart@epa.gov.") 
  exp_df <- data.frame(service, description)
  expect_equal(found_df, exp_df)
})

test_that("Extra char in list get removed", {
  service <- c("Sign up")
  description <- c("Email will\r\n\t\t\t\t\t\t\t be sent to the registered address from aqsdatamart@epa.gov.")
  og_list <- list("service" = service, "description" = description)
  found_list <- list.remove.escapes.spaces(og_list)
  description <- c("Email will be sent to the registered address from aqsdatamart@epa.gov.") 
  exp_list <- list("service" = service, "description" = description)
  expect_equal(found_list, exp_list)
})



