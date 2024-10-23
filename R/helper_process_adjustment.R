#' Process Adjustment Data in a Data Frame
#'
#' The `helper_process_adjustment` function processes the `adjustment` column in a given data frame. It validates the data, converts categorical values ("more" and "less") into numeric equivalents, and handles missing values appropriately.
#'
#' @param df A data frame containing an `adjustment` column. The `adjustment` column can contain numeric values (0-100) or categorical values ("more" or "less").
#'
#' @return A data frame with the `adjustment` column transformed based on the rules provided.
#'
#' @examples
#' data("valid_trip_data", package = "costsplitter")
#' data_adjustment <- helper_process_adjustment(df = valid_trip_data)
#'
#' @details
#' The function performs the following steps:
#' 1. **Assertive Tests**: Validates that the `adjustment` column exists and that it contains only numeric values (0-100) or the categorical values "more" and "less".
#' 2. **Conversion**:
#'    - Converts "more" to 1.2 and "less" to 0.8.
#'    - Replaces `NA` and empty values with 1.
#'
#' @importFrom assertthat assert_that
#' @importFrom dplyr mutate as_tibble
#' @importFrom rlang .data
#'
#' @family helper
#'
#' @export
helper_process_adjustment <- function(df = helper_check_names(df)) {

  # -----------Set adjustment to one if it is missing -------------------------------------------

  if (!("adjustment" %in% names(df))) {
    df$adjustment <- "1"
  }

  # ----- Assertive tests -------------------------------------------------

  # Separate categorical and numerical values
  data_test_categorical <- df$adjustment[suppressWarnings(is.na(as.numeric(df$adjustment)))]
  data_test_categorical <- data_test_categorical[!is.na(data_test_categorical)]
  data_test_categorical <- data_test_categorical[data_test_categorical != ""]
  data_test_numerical <- as.numeric(df$adjustment[suppressWarnings(!is.na(as.numeric(df$adjustment)))])

  # Check the categorical values
  assertthat::assert_that(
    all(data_test_categorical %in% c("more", "less")) || length(data_test_categorical) == 0,
    msg = "The adjustment column can contain categorical values, but they must be either 'more' or 'less'."
  )

  # Check the numerical values
  assertthat::assert_that(
    all(data_test_numerical <= 100 & data_test_numerical >= 0) || length(data_test_numerical) == 0,
    msg = "The adjustment column can be numeric but the values must be from 0 to 100."
  )

  # ----------- Conversions -------------------------------------------
  # Convert adjustment to character to handle all types properly
  df$adjustment <- as.character(df$adjustment)

  # Replace categorical values with numeric equivalents
  df$adjustment[df$adjustment == "more"] <- 1.2
  df$adjustment[df$adjustment == "less"] <- 0.8

  # Replace NAs and empty values with 1
  df$adjustment[df$adjustment == "" | is.na(df$adjustment)] <- 1

  # Convert adjustment to numeric
  df$adjustment <- as.numeric(df$adjustment)

  # ------Pivot longer ------------------------------------------------
  df <- df |>
    tidyr::pivot_longer(cols = dplyr::starts_with("share"), names_to = "activity", values_to = "delete") |>
    dplyr::mutate(activity = stringr::str_split_i(pattern = "_", .data$activity, i = 2)) |>
    dplyr::select(.data$name, .data$activity, .data$adjustment) |>
    dplyr::as_tibble()

  return(df)
}
