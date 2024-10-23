#' Costs Splitter Function
#'
#' This function processes a dataset of costs and divides the total costs based on specified criteria.
#' It calculates the amount each group or individual needs to pay, considering various factors such as
#' age, share, and adjustments.
#'
#' @param df A dataframe containing the cost data. The dataframe must have at least the following columns:
#' \itemize{
#'   \item `name`: Name of the participant.
#'   \item `group`: Group identifier.
#'   \item `age`: Age of the participant.
#'   \item Columns starting with `"share"`: Columns indicating the share of costs.
#'   \item Columns for `adjustment` and `pay`: Columns indicating adjustments and payments.
#' }
#' @param pay_by A character string specifying whether the costs should be split by `"group"` (default) or `"individual"`.
#' @return A dataframe with the total amount to pay per group or individual based on the specified criteria.
#' @export
#'
#'
#' @examples
#' df <- tibble::tibble(
#'   name = c("Alice", "Bob", "Charlie"),
#'   group = c("Group1", "Group1", "Group2"),
#'   age = c("adult", "kid", 30),
#'   share_meal = c(0.5, 0.3, 0.7),
#'   share_tour = c(0.4, 0.6, 0.5),
#'   adjustment = c(1.0, 0.8, 1.2),
#'   pay_meal = c(100, 50, 150),
#'   pay_tour = c(200, 100, 250)
#' )
#' costsplitter(df, pay_by = "group")
#'
costsplitter <- function(df, pay_by = "group"){

  data_clean <- df |>
    helper_check_names() |>
    helper_process_name() |>
    dplyr::left_join(helper_process_age(df), by = dplyr::join_by(name, activity)) |>
    dplyr::left_join(helper_process_adjustment(df), by = dplyr::join_by(name, activity)) |>
    dplyr::left_join(helper_process_share(df), by = dplyr::join_by(name, activity)) |>
    dplyr::left_join(helper_process_pay(df), by = dplyr::join_by(name, activity)) |>
    dplyr::mutate(weight = share * age * adjustment)

  data_complete <- data_clean |>
    dplyr::left_join(
      data_clean |>
        dplyr::group_by(activity) |>
        dplyr::summarise(pay_per_activity = sum(pay)),
      by = dplyr::join_by(activity)
    ) |>
    dplyr::left_join(
      data_clean |>
        dplyr::group_by(activity) |>
        dplyr::summarise(weight_per_activity = sum(weight)),
      by = dplyr::join_by(activity)
    ) |>
    dplyr::mutate(pay_per_share = pay_per_activity / weight_per_activity) |>
    dplyr::mutate(to_pay = weight * pay_per_share - pay)

  if(pay_by == "group"){
    data_to_split <- data_complete |>
      dplyr::group_by(group) |>
      dplyr::summarise(to_pay = sum(to_pay)) |>
      dplyr::select(element = group, to_pay)
  } else {
    data_to_split <- data_complete |>
      dplyr::group_by(name) |>
      dplyr::summarise(to_pay = sum(to_pay)) |>
      dplyr::select(element = name, to_pay)
  }

  data_to_split <- helper_minimize_payments(data_to_split)

  data_to_split$amount <- round(data_to_split$amount)

  # Arrange by payer
  data_to_split <- data_to_split |> dplyr::arrange(payer)

  return(data_to_split)
}

