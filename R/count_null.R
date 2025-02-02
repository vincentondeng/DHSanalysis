#' Count Null Values in a Data Frame
#'
#' This function counts the number of null (NA) values for each column in a data frame.
#'
#' @param df A data frame or tibble.
#' @return A tibble with each variable as a row and its corresponding null count.
#' @examples
#' df <- data.frame(Age = c(25, 30, 35, 40, NA), Gender = c("M", "F", "M", "F", NA))
#' count_nulls(df)
#' @export
count_nulls <- function(df) {
  library(dplyr)

  if (!is.data.frame(df)) {
    stop("Error: Input must be a data frame or tibble.")
  }

  # Compute null counts for all variables
  null_counts <- df %>% summarise_all(~ sum(is.na(.))) %>%
    pivot_longer(everything(), names_to = "Variable", values_to = "Null_Count")

  return(null_counts)
}
