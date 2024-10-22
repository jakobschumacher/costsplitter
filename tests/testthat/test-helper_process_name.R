# Test data for the tests
df_valid <- tibble::tibble(
  name = c("Alice", "Bob", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5)
)

df_duplicated_name <- tibble::tibble(
  name = c("Alice", "Alice", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5)
)


test_that("costsplitter::helper_process_name works correctly for valid data", {
  result <- helper_process_name(df_valid)

  # Check that the output has the expected columns
  expect_true(all(c("name", "group", "activity") %in% colnames(result)))

  # Check the number of rows; should be twice the number of original rows due to pivot_longer
  expect_equal(nrow(result), nrow(df_valid) * 2)

  # Check that all names are correctly preserved
  expect_equal(unique(result$name), df_valid$name)
})

test_that("Helper_process_name returns error for duplicated names", {
  expect_error(helper_process_name(df_duplicated_name),
               regexp = "The name column cannot contain duplicated values")
})
