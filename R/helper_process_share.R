#' Process Share Data in a Data Frame
#'
#' The `helper_process_share` function processes the `share` columns in a given data frame. It pivots the share columns into a long format, validates the data, and converts categorical share values into numeric equivalents. The function also replaces missing or empty values with 0.
#'
#' @param df A data frame containing columns that start with "share" and a `name` column. The share columns can contain numeric values (0-1) or categorical values ("full", "reduced", "half", "some").
#'
#' @return A tibble with three columns: `name`, `activity`, and `share`. The share values are transformed based on the rules provided, and the data is pivoted to a long format.
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
#' @examples
#'data("valid_trip_data", package = "costsplitter")
#'df <- valid_trip_data
#'data_share <- helper_process_share(df)
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
helper_process_share <- function(df = helper_check_names(df)) {

  df <- df |>
    tidyr::pivot_longer(starts_with("share"), names_to = "activity", values_to = "share") |>
    dplyr::mutate(activity = stringr::str_split_i(pattern = "_", activity, i = 2)) |>
    select(name, activity, share)


  # -----Assertive tests-------------------------------------------------
  # Assertive tests preparation
  data_test_categorical <- df$share[suppressWarnings(is.na(as.numeric(df$share)))]
  data_test_categorical <- data_test_categorical[!is.na(data_test_categorical)]
  data_test_categorical <- data_test_categorical[data_test_categorical != ""]
  data_test_numerical <- as.numeric(df$share[suppressWarnings(!is.na(as.numeric(df$share)))])

  # Check the categorical part
  assertthat::assert_that(all(data_test_categorical %in% c("full", "reduced", "half", "some") ) || length(data_test_categorical) == 0 , msg = "The share column can contain categorical values, but they must be either 'full', 'reduced', 'half', 'some' ")

  # Check the numerical part
  assertthat::assert_that(all(is.numeric(data_test_numerical) & data_test_numerical <=100 & data_test_numerical >=0) || length(data_test_categorical) == 0, msg = "The share column can be numeric but the values must be from 0 to 100")


  # -----------Conversions-------------------------------------------
  # Convert age to character to handle all types properly
  df$share <- as.character(df$share)

  # Replace categorical values with numeric equivalents
  df$share[df$share == "full"] <- 1
  df$share[df$share == "reduced"] <- 0.7
  df$share[df$share == "half"] <- 0.5
  df$share[df$share == "some"] <- 0.3

  # Replace NAs and empty values with 0
  df$share[df$share == "" | is.na(df$share)] <- 0

  # Convert share to numeric
  df$share <- as.numeric(df$share)


  df <- df |>
    dplyr::as_tibble()

  return(df)
}
