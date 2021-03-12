#' Clean web-scraped data.
#'
#' A function to clean web-scraped data given the tibble containing raw data .
#'
#'
#' @param scraped_df A tibble containing web-scraped data like listing url, price and house type.
#'
#' @return tibble A cleaned tibble containing information like listing url, price, number of bedrooms, area in sqft, and city.
#' @export
#' @examples
#' data_cleaner(pd.read_csv('tests/cleaned_toy_data.csv'))
data_cleaner <- function(scraped_df) {
  if (!tibble::is_tibble(scraped_df)) {
    stop("Cannot do the data cleaning for a non-tibble input")
  } else if (dim(scraped_df)[1] == 0) {
    stop("Cannot do the data cleaning for a empty tibble")
  } else if (!"price" %in% colnames(scraped_df)) {
    stop("The price column is missing")
  } else if (!"house_type" %in% colnames(scraped_df)) {
    stop("The house_type column is missing")
  } else if (!"listing_url" %in% colnames(scraped_df)) {
    stop("The listing_url column is missing")
  } else{

    cleaned_df <- scraped_df

    # Create the list of cities in metro vancouver
    city_list <- c("Bowen Island", "Burnaby", "Coquitlam", "Delta", "Langley", "Maple Ridge",
                   "New Westminster", "North Vancouver", "Pitt Meadows", "Port Coquitlam", "Port Moody",
                   "Richmond", "Surrey", "Vancouver","West Vancouver", "White Rock")

    # convert the price column into numeric data types
    cleaned_df$price <- as.character(cleaned_df$price)
    cleaned_df$price <- stringr::str_remove_all(cleaned_df$price, "[$,]")
    cleaned_df$price <- as.integer(cleaned_df$price)


    # extract the information about the number of bedroom of the housing
    cleaned_df$num_bedroom <- stringr::str_extract_all(cleaned_df$house_type, "[0-9]+[b]{1}[r]{1}")
    cleaned_df$num_bedroom [length(cleaned_df$num_bedroom) == 0] <- NA
    cleaned_df$num_bedroom <- as.character(cleaned_df$num_bedroom)
    cleaned_df$num_bedroom <- stringr::str_remove_all(cleaned_df$num_bedroom, "[br]")
    cleaned_df$num_bedroom <- suppressWarnings(as.integer(cleaned_df$num_bedroom))

    # extract the information about the area of the housing
    cleaned_df$area_sqft <- stringr::str_extract_all(cleaned_df$house_type, "[0-9]+[f]{1}[t]{1}[2]{1}")
    cleaned_df$area_sqft[length(cleaned_df$area_sqft) == 0] <- NA
    cleaned_df$area_sqft <- as.character(cleaned_df$area_sqft)
    cleaned_df$area_sqft <- stringr::str_remove_all(cleaned_df$area_sqft, "ft2")
    cleaned_df$area_sqft <- suppressWarnings(as.integer(cleaned_df$area_sqft))

    # extract the information about which city are the housing located in
    cleaned_df$city <- stringr::str_extract_all(cleaned_df$listing_url, "[d]{1}[/]{1}[a-z]+[-]{1}")
    cleaned_df$city <- stringr::str_remove_all(cleaned_df$city, 'd/')
    cleaned_df$city <- stringr::str_remove_all(cleaned_df$city, '-')
    cleaned_df$city <- stringr::str_to_title(cleaned_df$city)
    cleaned_df$city <- lapply(cleaned_df$city, function(x)x[which(x %in% city_list)])
    cleaned_df$city <- tolower(cleaned_df$city)
    cleaned_df$city[cleaned_df$city == "character(0)"] <- NA

    # select the columns which are useful for future filterin
    cleaned_df <- dplyr::select(cleaned_df, listing_url, price, num_bedroom, area_sqft, city)
  }
  return(cleaned_df)
}
