#' Function to scrape housing data from a given craiglist url
#'
#' @param url The given craiglist url to scrape the data from
#' @param online Whether the data is scraped directly online from the url (default = False). False means the data is scraped from local HTML file
#' @param save_csv Whether to export the data to CSV file (default = False)
#'
#' @return tibble A dataframe containing listing information such as price, house type and neighborhood. A csv containing the dataframe could also be exported with `save_csv` option is activated to True.
#' @export
#'
#' @examples
#' scraper(url = 'https://vancouver.craigslist.org/search/van/apa', save_csv = True)
scraper <- function(url, online = False, save_csv = False) {

}
