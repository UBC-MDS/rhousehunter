# Tests on input
# Create tibbles for testing 
empty_tibble <- tibble::tibble("price" = c(), 
                               "house_type"= c(), 
                               "listing_url"= c())
toy_tibble <- tibble::tibble("price" = c(100,200), 
                             "house_type"= c("House", "Condo"), 
                             "listing_url"= c(123, 456))
not_tibble <- data.frame(house = "house1")

# Test to confirm that function is aborted when invalid email is input
testthat::test_that("Error in send_email(): the email is not a valid",{
  testthat::expect_error(send_email(123,toy_tibble))
  testthat::expect_error(send_email("ela",toy_tibble))
  testthat::expect_error(send_email("ela.com",toy_tibble))
})

# Test to confirm that function is aborted when invalid subject is input
testthat::test_that("Error in send_email(): the email is not a valid",{
  testthat::expect_error(send_email("hello@world.com",toy_tibble, 123))
  testthat::expect_error(send_email("hello@world.com",toy_tibble, FALSE))
})

# Test to confirm that function is aborted when input is not a tibble
testthat::test_that("Error in send_email(): the input is not a tibble",{
  testthat::expect_error(send_email("helloworld@gmail.com", not_tibble))
})

# Test to confirm that function is aborted when tibble is empty
testthat::test_that("Error in send_email(): the input tibble is empty",{
  testthat::expect_error(send_email("helloworld@gmail.com", empty_tibble))
})

# Tests on output
# Test that output is an 'S4' object fo class 'jobjRef'
testthat::test_that("Error in send_email(): Email not Sent",{
  testthat::expect_s4_class(send_email("hello@new.com", toy_tibble),'jobjRef')
})

