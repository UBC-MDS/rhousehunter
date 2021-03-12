library(tidyverse)
library(mailR)

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
  
  email_pattern <- "\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>"
  
  if (!is.str(email_recipient)){
    rlang::abort("The email address must be a string. Aborting.")
    }
  if (grepl(email_pattern, email_recipient, ignore.case=TRUE) == FALSE) {
  rlang::abort("You have input an invalid Email Address. Aborting.")
    } 
  if (!tidyverse::is_tibble(filtered_data)) {
    rlang::abort("The filtered results must be a tibble. Aborting.")
    }
  if (!tidyverse::is_tibble(filtered_data)) {
  rlang::abort("The filtered results must be a tibble. Aborting.")
    }
  if (dim(filtered_data)[1] == 0) {
    rlang::abort("Your tibble is empty and no results to be emailed. Aborting.")
  }
    
  file_path <- tempfile()
  readr::write_csv(filtered_data, file_path)
  
  mailR::send.mail(from = "pyhousehunter@gmail.com",
                   to = email_recipient,
                   subject = email_subject,
                   body = "Results meeting your specifications are attached.",
                   smtp = list(host.name = "smtp.gmail.com", port = 587, 
                               user.name = "pyhousehunter@gmail.com",            
                               passwd = "dsci524group6", tls = TRUE), 
                   authenticate = TRUE,
                   send = TRUE,
                   attach.files = file_path,
                   file.names = "Results.csv") 
  }

