#' Checks if the correct names are present
#'
#' The `helper_check_names` function checks if the names are correct. For those that can be missing the variable is created with the correct default value.
#'
#' @param df A data frame containing an the right columns.
#'
#' @return A data frame with all the right columns
#'
#' @examples
#' df <- helper_check_names(df)
#'
#'
#' @importFrom assertthat assert_that
#' @importFrom dplyr mutate as_tibble
#' @importFrom rlang .data
#'
#'@family helper
#'
#' @export
helper_check_names <- function(df){

  assertthat::assert_that("name" %in% names(df), msg = "The name column is missing.")

  assertthat::assert_that(any(grepl("share", names(df), ignore.case = TRUE)), msg = "There should be at least one share column.")

  assertthat::assert_that(any(grepl("pay", names(df), ignore.case = TRUE)), msg = "There should be at least one pay column.")


  # Extract suffixes from column names
  pay_suffixes <- names(df) |>  stringr::str_subset("^pay_") |> stringr::str_remove("^pay_")
  share_suffixes <- names(df) |> stringr::str_subset("^share_") |> stringr::str_remove("^share_")

  # Check if all pay_suffixes have a corresponding share_suffix
  missing_in_share <- setdiff(pay_suffixes, share_suffixes)
  missing_in_pay <- setdiff(share_suffixes, pay_suffixes)

  assertthat::assert_that(length(missing_in_share) == 0, msg = "Some pay_ columns do not have a matching share_ column.")
  assertthat::assert_that(length(missing_in_pay) == 0, msg = "Some share_ columns do not have a matching pay_ column.")


return(df)
}
