data("valid_trip_data", package = "costsplitter")
library(testthat)

# Test if the function runs without error for categorical values
testthat::test_that("Check that helper_process_pay runs an error for categorical values", {
  df <- valid_trip_data
  df$pay_meal = c("full", "full", "reduced", "half", "some")
  df$pay_tour = c("full", "half", "reduced", "full", "some")
  expect_error(helper_process_pay(df))
})

# Test if the function runs without error for numeric values within range
test_that("Check that helper_process_pay runs without error for numeric values", {
  df <- valid_trip_data
  df$pay_meal = c(8, 1, 0.5, 12, 6)
  df$pay_tour = c(8, 1, 0.5, 12, 6)

  expect_no_error(helper_process_pay(df))
})

# Test if the function runs without error for a mix of numeric and categorical values
test_that("Check that helper_process_pay runs with error for a mix of numeric and categorical values", {
  df <- valid_trip_data
  df$pay_meal = c(8, 1, "full", 12, 6)
  df$pay_tour = c(8, 1, 0.5, "half", 6)
  expect_error(helper_process_pay(df))
})

# Test if the function runs without error when there are NA values
test_that("Check that helper_process_pay runs without error for NA values", {
  df <- valid_trip_data
  df$pay_meal = c(NA, NA, NA, NA, NA)
  df$pay_tour = c(NA, NA, NA, NA, NA)
  expect_error(helper_process_pay(df))
})

# Test if the function output contains only the 'name', 'activity', and 'pay' columns
test_that("Output contains only 'name', 'activity', and 'pay'", {
  df <- valid_trip_data

  # Process the data frame
  processed_df <- helper_process_pay(df)

  # Get the names of the expected columns
  expected_columns <- c("name", "activity", "pay")

  # Test if the column names are exactly as expected
  expect_named(processed_df, expected_columns)
})
