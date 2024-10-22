

df_minimal <- tibble::tibble(
  name = c("Alice", "Bert", "Charlie"),
  group = c("Group1", "Group1", "Group2"),
  share_meal = c(0.5, 0.3, 0.7),
  share_tour = c(0.4, 0.6, 0.5),
  pay_meal = c(3,5,0),
  pay_tour = c(200, 100, 300)
)


test_that("Costsplitter works", {
  amount <- costsplitter(df_minimal, pay_by = "individual") |> dplyr::select(amount) |> dplyr::pull()
  expect_equal(amount, c(96, 40))
})
