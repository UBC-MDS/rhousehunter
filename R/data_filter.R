# library(dplyr)
#' Filter a cleaned tibble based on user input
#'
#' @param df tibble
#' @param min_price number
#' @param max_price number
#' @param sqrt_ft number
#' @param num_bedroom_input number
#' @param city_input char
#'
#' @return tibble
#' @export
#'
#' @examples data_filter(df, 1000, 2000, 500, 1, 'Vancouver')

# load cleaned df
cleaned_df <- read_csv('tests/testthat/cleaned_toy.csv')

data_filter <- function(df,
                        min_price,
                        max_price,
                        sqrt_ft,
                        num_bedroom_input,
                        city_input){
  # check to ensure user inputs are of the correct types
  if(!is.numeric(min_price) | min_price < 0){
    stop("Minimum price entered is not a positive number!")
  }
  if(!is.numeric(max_price) | max_price < min_price){
    stop("Maximum price entered has to be a positive number larger than minimun
         price!")
  }
  if(!is.numeric(sqrt_ft)){
    stop("Area entered is not a number!")
  }
  if(num_bedroom_input < 0){
    stop("Minimum number of bedroom cannot be negative!")
  }
  if(!is.character(city_input)){
    stop("The city entered is not a character!")
  }

  # filter function body
  dplyr::filter(df,
                between(price, min_price, max_price) &
                (is.na(area_sqft) | area_sqft >= sqrt_ft) &
                (is.na(num_bedroom) | num_bedroom >= num_bedroom_input) &
                (is.na(city) | city == tolower(city_input))
  )}

