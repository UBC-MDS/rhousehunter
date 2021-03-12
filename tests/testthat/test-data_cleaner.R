# Tests on input

testthat::test_that("Error in scraper(): URL input is missing", {
  expect_error(scraper(online = TRUE))
  expect_error(scraper())
})

## Test to confirm that ValueError is raised when the required scraped_df input is not a tibble
testthat::test_that("Error in data_cleaner(): the input is not a tibble",{
  testthat::expect_error(data_cleaner("raw.html"))
  testthat::expect_error(data_cleaner(123))
})

## Test to confirm the input tibble is not empty
testthat::test_that("Error in data_cleaner(): the input tibble is empty",{
  testthat::expect_error(data_cleaner(tibble::tibble("price" = interger(), "house_type":character(), "listing_url": character())))
})

## Test to confirm that ValueError is raised when the scraped_df input is missing the price column
testthat::test_that("Error in data_cleaner(): the input dataframe is missing the price column",{
  testthat::expect_error(data_cleaner(tibble::tibble("house_type"= c("1", "2"), "listing_url" = c("2", "3"))))
})

## Test to confirm that ValueError is raised when the scraped_df input is missing the house_type column
testthat::test_that("Error in data_cleaner(): the input dataframe is missing the price column",{
  testthat::expect_error(data_cleaner(tibble::tibble("price"= c(1, 2), "listing_url" = c("2", "3"))))
})

## Test to confirm that ValueError is raised when the scraped_df input is missing the listing_url column
testthat::test_that("Error in data_cleaner(): the input dataframe is missing the price column",{
  testthat::expect_error(data_cleaner(tibble::tibble("price"= c(1, 2), "house_type"= c("1", "2"))))
})


# Tests on output

toy_scraped_df <- readr::read.csv('tests/toy.csv')
output_df <- data_cleaner(toy_scraped_df)
toy_cleaned_df <- readr::read_csv("cleaned_toy.csv", col_types = readr::cols(price = "i", num_bedroom = "i", area_sqft = "i"))

## Test to confirm the output tibble is not empty
testthat::test_that("The cleaned tibble should not be empty", {
  testthat::expect_true(dim(output_df)[1] != 0)
})

## Test to confirm the dimension of the output tibble is correct
testthat::test_that("The cleaned tibble should have the same shape as the input tibble", {
  testthat::expect_true(dim(output_df)[1] == dim(toy_scraped_df)[1])
  testthat::expect_true(dim(output_df)[2] == dim(toy_scraped_df)[1])
})

## Test to confirm that the data type of price column of the output tibble is integer
testthat::test_that("The data type of price column of the output tibble should be interger", {
  testthat::expect_true(class(output_df[["price"]]) == "integer" )
})

## Test to confirm that the data type of num_bedroom column of the output dataframe is interger
testthat::test_that("The data type of price column of the output tibble should be interger", {
  testthat::expect_true(class(output_df[["num_bedroom"]]) == "integer" )
})

## Test to confirm that the data type of area_sqft column of the output tibble is integer
testthat::test_that("The data type of price column of the output tibble should be interger", {
  testthat::expect_true(class(output_df[["area_sqft"]]) == "integer" )
})

## Test to confirm that the data type of city column of the output tibble is character
testthat::test_that("The data type of price column of the output tibble should be interger", {
  testthat::expect_true(class(output_df[["city"]]) == "character" )
})

## Test to confirm that the output tibble have correct names ready for future filtering
testthat::test_that("The columns of the output tibble should have correct names ready for future filtering", {
  testthat::expect_equal(colnames(data), c("listing_url", "price", "num_bedroom", "area_sqft", "city"))
})

## Test to confirm that the output tibble matches cleaned toy data
testthat::test_that("The scraped data frame contains data in toy dataset", {
  testthat::expect_true(dplyr::all_equal(output, toy_cleaned_df))
})
