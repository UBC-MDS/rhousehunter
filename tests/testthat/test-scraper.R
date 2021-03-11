
url <-  'https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa'

# Tests on input

# Test scraper() to raise error if URL input is missing
test_that("ERROR when running scraper(): URL input is missing", {
  expect_error(scraper(online = TRUE))
  expect_error(scraper())
})

# Test scraper() to raise error if URL input is not a string
test_that("ERROR when running scraper(): URL input should be a string", {
  expect_error(scraper(url = 123, online = TRUE))
  expect_error(scraper(url = TRUE, online = TRUE))
})

# Test scraper() to raise error when required URL input is not a valid Craiglist housing URL
test_that("ERROR when running scraper(): URL input needs to be a valid Craiglist housing URL", {
  expect_error(scraper(url = "https://www.haha.com", online = TRUE))
  expect_error(scraper(url = "https://wiki.ubc.ca/Main_Page", online = TRUE))
})

#  Test scraper() to raise error the optional input `online` is not a Boolean
test_that("ERROR when running scraper(): `online` need to be a Boolean", {
  expect_error(scraper(url = url, online = 1))
  expect_error(scraper(url = url, online = 'sunny'))
  expect_error(scraper(url = url, online = '25yrs?'))
})
s
# Tests on output
data <- scraper(url = url, online = TRUE)

# Test to confirm the output tibble is not empty
test_that("Output tibble is not empty", {
  expect_true(dim(data)[1] != 0)
})

# Test to confirm the dimension of the output tibble is correct
test_that("Output tibble has the correct shape", {
  expect_true(dim(data) == c(120,5))
})

# Test to confirm the data type of each column of the output tibble is string

# 4 more tests

