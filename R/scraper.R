#' Function to scrape housing data from a given craiglist url
#'
#' @param url The given Craiglist url to scrape the data from.
#' @param online Whether the data is scraped directly from the url online (default = False). False means the data is scraped from a local HTML file.
#'
#' @return tibble A tibble containing listing information such as listing url, price, and house type
#' @export
#'
#' @examples
#' scraper(url = "https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa")
scraper <- function(url, online = FALSE) {
  # PART1: Create node object from URL
  if (online == TRUE){
    download.file(url, destfile = "R/temp/van_housing_listings_new.html", method="curl", extra="-k")
    page <- xml2::read_html("R/temp/van_housing_listings_new.html")
  } else{
    page <- xml2::read_html("R/temp/van_housing_listings.html")
  }


  # PART2: Extracted from node object
  nodes <- rvest::html_nodes(page, ".result-info")
  data <- tibble::tibble(
    listing_url = character(),
    price = character(),
    house_type = character()
  )

  for (i in 1:length(nodes)) {
    listing_url <- rvest::html_attr(rvest::html_node(nodes[i], "a"), "href")
    price <- rvest::html_text(rvest::html_node(nodes[i], 'span[class="result-price"]'))
    house_type <- gsub("\r\n", "", gsub(" ", "", rvest::html_text(rvest::html_node(nodes[i], 'span[class="housing"]')), fixed = TRUE), fixed = TRUE)
    data <- tibble::add_row(data, listing_url = listing_url, price = price, house_type = house_type)
  }

  data
}


# TO REMOVE upon final edit
# Check out result
url <- "https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa"
data <- scraper(url, online = FALSE)


# Write data to csv
readr::write_csv(data , file = "raw.csv")



