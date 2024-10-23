#' Process Share Data in a Data Frame
#'
#' The `helper_process_share` function processes the `share` columns in a given data frame. It pivots the share columns into a long format, validates the data, and converts categorical share values into numeric equivalents. The function also replaces missing or empty values with 0.
#'
#' @param df A data frame containing columns that start with "share" and a `name` column. The share columns can contain numeric values (0-1) or categorical values ("full", "reduced", "half", "some").
#'
#' @return A tibble with three columns: `name`, `activity`, and `share`. The share values are transformed based on the rules provided, and the data is pivoted to a long format.
#'
#' @examples
#'data("valid_trip_data", package = "costsplitter")
#'df <- valid_trip_data
#'data_pay <- helper_process_pay(df)
#'
#'
#' @details
#' The function performs the following steps:
#' 1. **Pivoting**: Converts the wide format share columns into a long format with `activity` and `share` columns.
#' 2. **Assertive Tests**: Validates that the `share` column contains only numeric values (0-1) or the specified categorical values ("full", "reduced", "half", "some").
#' 3. **Conversion**:
#'    - Converts categorical values ("full", "reduced", "half", "some") into numeric equivalents (1, 0.7, 0.5, 0.3).
#'    - Replaces `NA` and empty values with 0.
#' 4. **Transformation**: Ensures that the `share` column is numeric and returns the modified data frame as a tibble.
#'
#' @importFrom assertthat assert_that
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr mutate select as_tibble
#' @importFrom stringr str_split_i
#' @importFrom rlang .data
#'
#' @family helper
#'
#' @export
helper_process_pay <- function(df) {

  df <- df |>
    tidyr::pivot_longer(dplyr::starts_with("pay"), names_to = "activity", values_to = "pay") |>
    dplyr::mutate(activity = stringr::str_split_i(pattern = "_", .data$activity, i = 2)) |>
    dplyr::select(name, activity, pay)


  # -----Assertive tests-------------------------------------------------
  # Check the categorical part
  assertthat::assert_that(all(is.numeric(df$pay)) || all(is.na(df$pay)) , msg = "The pay column must be numeric or only NA")

  # Check the categorical part
  assertthat::assert_that(all(df |>
                                dplyr::group_by(.data$activity) |>
                                dplyr::summarise(sum = sum(.data$pay, na.rm = TRUE)) |>
                                dplyr::filter(sum > 0) |>
                                nrow() > 0), msg = "For each activity there must be at least somebody who paied.")


  # ----- Conversions -------------------------------------------------
  # Replace NAs and empty values with 0
  df$pay[df$pay == "" | is.na(df$pay)] <- 0

  df <- df |>
    dplyr::as_tibble()

  return(df)
}
