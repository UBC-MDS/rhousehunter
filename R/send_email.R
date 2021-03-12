#' A function to email search results.
#'
#' @param email_recipient A string containing the email address of the recipient.
#'
#' @param filtered_data A tibble containing the filtered search results.
#'
#' @param email_subject A string containing the desired subject of the email.
#' Optional argument with default value of  'Results from RHouseHunter'.
#'
#' @return None.
#' @export
#'
#' @examples
#' send_email("helloworld@gmail.com", df)
#' send_email("helloworld@gmail.com", df, "Scraping Results 2")
send_email <- function(email_recipient, filtered_data,
                       email_subject = 'Results from RHouseHunter') {

}
