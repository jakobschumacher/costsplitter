#' Process Age Data in a Data Frame
#'
#' The `helper_process_age` function processes the `age` column in a given data frame. It performs assertive tests to validate the data, converts categorical age values ("adult" and "kid") into numeric equivalents, and scales numeric age values according to specified rules. Additionally, it pivots the data to transform share columns into long format and extracts activities.
#'
#' @param df A data frame containing an `age` column and other columns that start with "share". The `age` column can contain numeric values (0-120) or categorical values ("adult" or "kid").
#'
#' @return A tibble with three columns: `name`, `activity`, and `age`. The age values are transformed based on the rules provided, and the data is pivoted to a long format.
#'
#' @details
#' The function performs the following steps:
#' 1. **Assertive Tests**: Validates that the `age` column exists and that it contains only numeric values (0-120) or the categorical values "adult" and "kid".
#' 2. **Conversion**:
#'    - Converts "adult" to 1 and "kid" to 0.5.
#'    - Replaces `NA` and empty values with 1.
#'    - Scales numeric values above 1 by dividing by 18.
#' 3. **Data Transformation**: Pivots columns that start with "share" into a long format with `activity` and `age` columns.
#'
#' @importFrom assertthat assert_that
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr mutate select as_tibble
#' @importFrom stringr str_split_i
#' @importFrom rlang .data
#'
#' @examples
#' data("valid_trip_data", package = "costsplitter")
#' df <- valid_trip_data
#' data_age <- helper_process_age(df)
#'
#' @family helper
#'
#' @export
helper_process_age <- function(df = helper_check_names(df)) {

  # -----------Set age to one if it is missing -------------------------------------------
  if (!("age" %in% names(df))) {
    df$age <- "1"
  }

  # -----Assertive tests-------------------------------------------------
  # Assertive tests preparation
  data_test_categorical <- df$age[suppressWarnings(is.na(as.numeric(df$age)))]
  data_test_categorical <- data_test_categorical[!is.na(data_test_categorical)]
  data_test_categorical <- data_test_categorical[data_test_categorical != ""]
  data_test_numerical <- as.numeric(df$age[suppressWarnings(!is.na(as.numeric(df$age)))])

  # Check the categorical part
  assertthat::assert_that(all(data_test_categorical %in% c("adult", "kid") ) || length(data_test_categorical) == 0 , msg = "The age column can contain categorical values, but they must be either 'adult' or 'kid'")

  # Check the numerical part
  assertthat::assert_that(all(is.numeric(data_test_numerical) & data_test_numerical <=120 & data_test_numerical >=0) || length(data_test_categorical) == 0, msg = "The age column can be numeric but the values must be from 0 to 120")




  # -----------Conversions-------------------------------------------
  # Convert age to character to handle all types properly
  df$age <- as.character(df$age)

  # Replace categorical values with numeric equivalents
  df$age[df$age == "adult"] <- 1
  df$age[df$age == "kid"] <- 0.5

  # Replace NAs and empty values with 1
  df$age[df$age == "" | is.na(df$age)] <- 1

  # Convert age to numeric
  df$age <- as.numeric(df$age)

  # Scale down ages greater than 1 to a fraction (age * 1/18)
  df$age[df$age > 1] <- df$age[df$age > 1] * (1/18)
  df$age[df$age > 1] <- 1

  # ------Pivot longer ------------------------------------------------
  df <- df |>
    tidyr::pivot_longer(cols = dplyr::starts_with("share"), names_to = "activity", values_to = "delete") |>
    dplyr::mutate(activity = stringr::str_split_i(pattern = "_", .data$activity, i = 2)) |>
    dplyr::select(.data$name, .data$activity, .data$age) |>
    dplyr::as_tibble()


  return(df)
}


