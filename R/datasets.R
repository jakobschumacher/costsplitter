#' Example Data: Valid Trip Data
#'
#' This dataset contains complete and valid information for testing the `costsplitter` package.
#' It follows all requirements, including proper columns for names, group, age, payments, shares, and adjustments.
#'
#' @keywords internal
#'
#' @format A data frame with 5 rows and 8 variables:
#' \describe{
#'   \item{name}{Participant's name, unique.}
#'   \item{group}{Group identifier for participants.}
#'   \item{age}{Age of the participant; can be numeric, 'adult', or 'kid'.}
#'   \item{pay_meal}{Amount paid by the participant for a meal.}
#'   \item{share_meal}{Proportion of meal cost each participant is responsible for.}
#'   \item{pay_tour}{Amount paid by the participant for a tour.}
#'   \item{share_tour}{Proportion of tour cost each participant is responsible for.}
#'   \item{adjustment}{Adjustments to be applied to each participant's cost.}
#' }
"valid_trip_data"



#' Example Data: Participants
#'
#' This dataset contains complete and valid information for testing the `costsplitter` package.
#' It follows all requirements, including proper columns for names, group, age, payments, shares, and adjustments.
#'
#' @format A data frame with 7 rows and 13 variables:
#' \describe{
#'   \item{id}{Unique identifier for each participant.}
#'   \item{name}{Participant's name, unique.}
#'   \item{group}{Group identifier for participants.}
#'   \item{age}{Age of the participant; can be numeric or categories like 'adult' or 'kid'.}
#'   \item{share_dinnerday1}{Proportion of the dinner cost on day 1 each participant is responsible for.}
#'   \item{pay_dinnerday1}{Amount paid by the participant for dinner on day 1.}
#'   \item{share_day1}{Proportion of the cost on day 1 each participant is responsible for.}
#'   \item{pay_day1}{Amount paid by the participant on day 1.}
#'   \item{share_day2}{Proportion of the cost on day 2 each participant is responsible for.}
#'   \item{pay_day2}{Amount paid by the participant on day 2.}
#'   \item{share_day3}{Proportion of the cost on day 3 each participant is responsible for.}
#'   \item{pay_day3}{Amount paid by the participant on day 3.}
#'   \item{adjustment}{Adjustments to be applied to each participant's cost.}
#' }
#'
#' @keywords internal
#'
"participants"




#' Example Data: Missing Columns Data
#'
#' This dataset is missing the mandatory `name` column, designed to test how the package handles missing essential columns.
#'
#' @keywords internal
#'
#' @format A data frame with 5 rows and 7 variables.
"missing_columns_data"





#' Example Data: Incorrect Share Values
#'
#' This dataset contains invalid values in the `share_` columns, designed to test the package's error handling for incorrect share values.
#'
#' @keywords internal
#'
#' @format A data frame with 4 rows and 8 variables.
"incorrect_share_values"



#' Example Data: Extra Unexpected Columns
#'
#' This dataset includes extra columns that are not recognized by the package, testing if it can ignore unnecessary data without affecting calculations.
#'
#' @keywords internal
#'
#' @format A data frame with 4 rows and 10 variables.
"extra_unexpected_columns"
