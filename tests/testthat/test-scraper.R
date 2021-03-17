library(testthat)

url <- "https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa"

# Tests on input

# Test scraper() to raise error if URL input is missing
test_that("Error in scraper(): URL input is missing", {
  expect_error(scraper(online = TRUE))
  expect_error(scraper())
  expect_error(scraper(NA, online = TRUE))
  expect_error(scraper("", online = TRUE))
})

# Test scraper() to raise error if URL input is not a string
test_that("Error in scraper(): URL input should be a string", {
  expect_error(scraper(url = 123, online = TRUE))
  expect_error(scraper(url = TRUE, online = TRUE))
})

# Test scraper() to raise error when required URL input is not a valid Craiglist housing URL
test_that("Error in scraper(): URL input needs to be a valid Craiglist housing URL", {
  expect_error(scraper(url = "https://www.haha.com", online = TRUE))
  expect_error(scraper(url = "https://wiki.ubc.ca/Main_Page", online = TRUE))
})

#  Test scraper() to raise error the optional input `online` is not a Boolean
test_that("Error in scraper(): `online` need to be a Boolean", {
  expect_error(scraper(url = url, online = 1))
  expect_error(scraper(url = url, online = "sunny"))
  expect_error(scraper(url = url, online = "25yrs?"))
})


# Tests on output
data <- scraper(url = url, online = TRUE)

# Test to confirm the output tibble is not empty
test_that("Output tibble is not empty", {
  expect_true(dim(data)[1] != 0)
})

# Test to confirm the dimension of the output tibble is correct
test_that("Output tibble has the correct shape", {
  expect_true(dim(data)[1] == 120)
  expect_true(dim(data)[2] == 3)
})

# Test to confirm the data type of each column of the output tibble is character type and with correct list name
test_that("Data type of each column of the output tibble is character type and with correct list name", {
  data_type <- lapply(data, class)
  expected_data_type <- list("character", "character", "character")
  names(expected_data_type) <- c("listing_url", "price", "house_type")
  expect_equal(colnames(data), c("listing_url", "price", "house_type"))
  expect_equal(data_type, expected_data_type)
})

local_data <- scraper(url = url, online = FALSE)
### for local data only
# Test to confirm that the scraped data frame contains data in toy dataset
test_that("The scraped data frame contains data in toy dataset", {
  print(getwd())
  toy <- read.csv("toy.csv")
  toy$price <- stringr::str_trim(toy$price)
  expect_true(dplyr::all_equal(as.data.frame(dplyr::semi_join(local_data, toy, by = "listing_url")), toy))
})
