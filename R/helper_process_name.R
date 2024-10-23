#' Process Name Column in the Dataframe
#'
#' This function checks and processes the `name` column in the dataframe.
#' It performs the following operations:
#' - Asserts that all values in the `name` column are unique.
#' - Converts and reshapes the dataframe to handle activity shares and groups.
#'
#' @param df A dataframe containing at least the following columns: `name`, `group`, and columns starting with `"share"`.
#' @return A tibble with columns: `name`, `group`, and `activity`.
#'
#'@importFrom rlang .data
#'
#' @family helper
#'
#' @export
#'
#' @examples
#' df <- tibble::tibble(
#'   name = c("Alice", "Bob", "Charlie"),
#'   group = c("Group1", "Group1", "Group2"),
#'   share_meal = c(0.5, 0.3, 0.7),
#'   share_tour = c(0.4, 0.6, 0.5)
#' )
#' helper_process_name(df)
helper_process_name <- function(df) {

  # -----Assertive tests-------------------------------------------------

  assertthat::assert_that("name" %in% names(df), msg = "The column 'name' must be present")

  assertthat::assert_that(any(grepl("share", names(df), ignore.case = TRUE)), msg = "At least one 'share' column must be present")

  assertthat::assert_that(all(!duplicated(df$name)), msg = "The name column cannot contain duplicated values")

  # -----------Conversions-------------------------------------------
  df <- df |>
    tidyr::pivot_longer(dplyr::starts_with("share"), names_to = "activity", values_to = "share") |>
    dplyr::mutate(activity = stringr::str_split_i(pattern = "_", .data$activity, i = 2)) |>
    dplyr::select(.data$name, .data$group, .data$activity)  |>
    dplyr::as_tibble()

  return(df)
}

