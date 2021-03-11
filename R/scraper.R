#' Function to scrape housing data from a given craiglist url
#'
#' @param url The given Craiglist url to scrape the data from.
#' @param online Whether the data is scraped directly from the url online (default = False). False means the data is scraped from a local HTML file.
#'
#' @return tibble A tibble containing listing information such as listing url, price, house type and .
#' @export
#'
#' @examples
#' scraper(url = "https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa")
scraper <- function(url, online = False) {
  # PART1: Create node object from URL
  page <- xml2::read_html(url)

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


# Check out result
url <- "https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa"
local_url <- "R/temp/van_housing_listings.html"
data <- scraper(local_url)













