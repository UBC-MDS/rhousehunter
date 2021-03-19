# library(dplyr)
#' Filter a cleaned tibble based on user input
#'
#' @param df tibble
#' @param min_price number minimum price
#' @param max_price number maximum price
#' @param sqrt_ft number footage of the unit
#' @param num_bedroom_input number number of bedrooms
#' @param city_input char the chosen city
#'
#' @return tibble
#' @export
#'
#' @examples
#' data_filter(tibble::tibble(
#'   "listing_url" = c("example.com"), "price" = c(1000),
#'   "num_bedroom" = c(1), "area_sqft" = c(500), "city" = c("vancouver")
#' ), 1000, 2000, 500, 1, "Vancouver")
data_filter <- function(df,
                        min_price,
                        max_price,
                        sqrt_ft,
                        num_bedroom_input,
                        city_input) {
  # check to ensure user inputs are of the correct types
  if (!is.numeric(min_price) | min_price < 0) {
    stop("Minimum price entered is not a positive number!")
  }
  if (!is.numeric(max_price) | max_price < min_price) {
    stop("Maximum price entered has to be a positive number larger than minimun
         price!")
  }
  if (!is.numeric(sqrt_ft)) {
    stop("Area entered is not a number!")
  }
  if (num_bedroom_input < 0) {
    stop("Minimum number of bedroom cannot be negative!")
  }
  if (!is.character(city_input)) {
    stop("The city entered is not a character!")
  }

  # filter function body
  dplyr::filter(
    df,
    dplyr::between(price, min_price, max_price) &
      (is.na(area_sqft) | area_sqft >= sqrt_ft) &
      (is.na(num_bedroom) | num_bedroom >= num_bedroom_input) &
      (is.na(city) | city == tolower(city_input))
  )
}
