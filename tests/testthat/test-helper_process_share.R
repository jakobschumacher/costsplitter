data("valid_trip_data", package = "costsplitter")
library(testthat)

# Test if the function runs without error for categorical values
test_that("Check that helper_process_share runs without error for categorical values", {
  df <- valid_trip_data
  df$share_meal = c("full", "full", "reduced", "half", "some")
  df$share_tour = c("full", "half", "reduced", "full", "some")
  expect_no_error(helper_process_share(df))
})

# Test if the function runs without error for numeric values within range
test_that("Check that helper_process_share runs without error for numeric values within range", {
  df <- valid_trip_data
  df$share_meal = c(8, 1, 0.5, 12, 6)
  df$share_tour = c(8, 1, 0.5, 12, 6)

  expect_no_error(helper_process_share(df))
})

# Test if the function runs without error for a mix of numeric and categorical values
test_that("Check that helper_process_share runs without error for a mix of numeric and categorical values", {
  df <- valid_trip_data
  df$share_meal = c(8, 1, "full", 12, 6)
  df$share_tour = c(8, 1, 0.5, "half", 6)
  expect_no_error(helper_process_share(df))
})

# Test if the function runs without error when there are NA values
test_that("Check that helper_process_share runs without error for NA values", {
  df <- valid_trip_data
  df$share_meal = c(8, 1, "full", "", 6)
  df$share_tour = c(8, 1, 0.5, "half", NA)
  expect_no_error(helper_process_share(df))
})

# Test if the function output contains only the 'name', 'activity', and 'share' columns
test_that("Output contains only 'name', 'activity', and 'share'", {
  df <- data.frame(
    name = c("John", "Jane", "Alex", "Kate", "Tom"),
    share_activity_walking = c(0.5, "full", "reduced", 0.7, "half"),
    share_activity_running = c("some", 0.3, 1, "full", 0.5)
  )

  # Process the data frame
  processed_df <- helper_process_share(df)

  # Get the names of the expected columns
  expected_columns <- c("name", "activity", "share")

  # Test if the column names are exactly as expected
  expect_named(processed_df, expected_columns)
})
