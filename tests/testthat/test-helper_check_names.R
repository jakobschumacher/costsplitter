df_missing_name <- tibble::tibble(
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5)
)

df_missing_share <- tibble::tibble(
  name = c("Alice", "Alice", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  pay_meal = c(0.5, 0.3, 0.7),
  pay_tour = c(0.4, 0.6, 0.5)
)


df_missing_pay <- tibble::tibble(
  name = c("Alice", "Alice", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5)
)


df_more_share_than_pay <- tibble::tibble(
  name = c("Alice", "Alice", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5),
  pay_tour = c(100,200,300)
)


df_more_pay_than_share <- tibble::tibble(
  name = c("Alice", "Alice", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  pay_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5),
  pay_tour = c(100,200,300)
)


df_adjustment_age_missing <- tibble::tibble(
  name = c("Alice", "Alice", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  pay_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5),
  pay_tour = c(100,200,300)
)


test_that("Helper_process_name does not throw an error if name is missing", {
  expect_error(helper_check_names(df_missing_name),
               regexp = "The name column is missing.")
})

test_that("Helper_process_name does not throw an error if share is missing", {
  expect_error(helper_check_names(df_missing_share),
               regexp = "There should be at least one share column.")
})


test_that("Helper_process_name does not throw an error if pay is missing", {
  expect_error(helper_check_names(df_missing_pay),
               regexp = "There should be at least one pay column.")
})


test_that("Helper_process_name does not throw an error if pay and share is unequal", {
  expect_error(helper_check_names(df_more_share_than_pay),
               regexp = "Some share_ columns do not have a matching pay_ column.")
})


test_that("Helper_process_name does not throw an error if pay and share is unequal", {
  expect_error(helper_check_names(df_more_pay_than_share),
               regexp = "Some pay_ columns do not have a matching share_ column.")
})


