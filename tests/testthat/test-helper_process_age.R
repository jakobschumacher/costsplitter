
data("valid_trip_data", package = "costsplitter")
testthat::test_that("Check that helper_process_age runs without error", {
  df <- valid_trip_data
  df$age <- c("adult", "adult", "kid", "kid", "kid")
  testthat::expect_no_error(helper_process_age(df))
})


testthat::test_that("Check that helper_process_age runs without error", {
  df <- valid_trip_data
  df$age <- c(1,3,4,6,7)
  testthat::expect_no_error(helper_process_age(df))
})

testthat::test_that("Check that helper_process_age runs without error", {
  df <- valid_trip_data
  df$age <- c(1,3,"adult",6,7)
  testthat::expect_no_error(helper_process_age(df))
})


testthat::test_that("Check that helper_process_age runs without error", {
  df <- valid_trip_data
  df$age <- c(1,3,"adult",NA,7)
  testthat::expect_no_error(helper_process_age(df))
})


testthat::test_that("Output contains only 'name', 'activity', and 'age'", {
  # Example output from your function
  df <- helper_process_age(valid_trip_data)

  # Get the names of the expected columns
  expected_columns <- c("name", "activity", "age")

  # Test if the column names are exactly as expected
  testthat::expect_named(df, expected_columns)
})

df_minimal <- tibble::tibble(
  name = c("Alice", "Bert", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5),
  pay_meal = c(3,5,0),
  pay_tour = c(NA, "", 300)
)

