df <- dplyr::tibble(
  element = c("Brown", "Smith", "Fisher", "Taylor", "Davis", "Johnson", "Wilson", "ORally"),
  to_pay = c(-995, -125, -80, 210, 245, 300, 365, 80)
)

df_solved <- helper_minimize_payments(df)

testthat::test_that("Test: Wilson's amount matches expectation", {
  testthat::expect_equal(df_solved |> dplyr::filter(payer == "Wilson") |> dplyr::pull(amount), 365)
})

testthat::test_that("Test: Total amount is 1200", {
  testthat::expect_equal(sum(df_solved$amount), 1200)
})

df2 <- dplyr::tibble(
  element = c("Brown", "Smith", "Fisher", "Taylor", "Davis", "Johnson", "Wilson", "ORally"),
  to_pay = c(-995, -125, -85, 210, 245, 300, 360, 80)
) |> helper_minimize_payments()

testthat::test_that("Test: Wilson's amount matches expectation for df2", {
  testthat::expect_equal(df2 |> dplyr::filter(payer == "Wilson") |> dplyr::pull(amount), 360)
})
