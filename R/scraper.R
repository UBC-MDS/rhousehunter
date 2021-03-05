#' Function to scrape housing data from a given craiglist url
#'
#' @param url The given Craiglist url to scrape the data from.
#' @param online Whether the data is scraped directly from the url online (default = False). False means the data is scraped from a local HTML file.
#'
#' @return tibble A dataframe containing listing information such as price, house type and neighborhood.
#' @export
#'
#' @examples
#' scraper(url = 'https://vancouver.craigslist.org/search/van/apa')
scraper <- function(url, online = False) {

}
