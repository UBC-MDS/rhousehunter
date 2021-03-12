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
scraper <- function(url, online = FALSE){
  # PART 0: Exception handling/ Input validation

  ## the right Craiglist URL
  if(is.na(url) || url == ""){
    stop("Missing URL. A Craiglist Housing URL input is required.")
  }

  if(!is.character(url)){
    stop("Wrong datatype: Please enter a correct Craiglist Housing URL.")
  }

  regex <- '(http|https):\\/\\/vancouver.craigslist.org\\/d\\/apartments-housing-for-rent\\/search\\/apa.*'
  if(length(grep(regex, url)) == 0){
    stop("Invalid URL. Please enter a Craiglist Housing URL with this format https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa")
  }


  ## the right option for online
  if(!is.logical(online)){
    stop("Wrong datatype: Please enter Boolean value: True or False for `online` parameter")
  }

  polite::use_manners()

  # PART1: Create node object from URL
  if (online == TRUE){
    source('R/polite-scrape.R')
    polite_download_file(url, destfile ='apa' ,overwrite=TRUE)
    page <- xml2::read_html('downloads/apa')
  } else{
    page <- xml2::read_html("downloads/van_housing_listings.html")
  }


  # PART2: Extracted from node object
  nodes <- rvest::html_nodes(page, ".result-info")
  data <- tibble::tibble(
    listing_url = character(),
    price = character(),
    house_type = character()
  )

  for (i in 1:length(nodes)) {
    listing_url_i <- rvest::html_attr(rvest::html_node(nodes[i], "a"), "href")
    price_i <- rvest::html_text(rvest::html_node(nodes[i], 'span[class="result-price"]'))
    house_type_i <- gsub("\n","",gsub("\r\n", "", gsub(" ", "", rvest::html_text(rvest::html_node(nodes[i], 'span[class="housing"]')), fixed = TRUE), fixed = TRUE), fixed = TRUE)
    data <- tibble::add_row(data, listing_url = listing_url_i, price = price_i, house_type = house_type_i)
  }
  data
}
