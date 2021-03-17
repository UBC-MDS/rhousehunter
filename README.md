# R House Hunter 
  <!-- badges: start -->
  [![R-CMD-check](https://github.com/UBC-MDS/rhousehunter/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/rhousehunter/actions)
  <!-- badges: end -->
 

R package for searching for housing on Craigslist.

-   Author: Ela Bandari, Junting He, Ling (Elina) Lin, Alex Truong


## Overview

Hunting for rentals can be an exhausting and frustrating experience in Canada, but this process can be made easy with a simple installation of our package. This Python package intends to facilitate the house hunting process by scraping the listing information from Craigslist and organizing the extracted data for the user. Instead of having to manually go on the website to catch up with individual new listings, the user will be updated through email with new results as per their selection criteria. 


## Functions

| Function Name | Input | Output | Description |
|-----------|------------|---------------|------------------|
| scraper | url | tibble | Scrape data from rental websites into a csv file.|
| data_cleaner | tibble | tibble | Clean the extracted data |
| data_filter | tibble, min_price, max_price, sqrt_ft, num_bathroom, num_bedroom, neighbourhood | tibble | Filter the cleaned data set based on user inputs|
| send_email | tibble, email address | None | Send the organized listing information to user email |



## Our Package in the R Ecosystem

To the best of our knowledge, there is currently no existing R package that simplifies the entire rental searching process with such a  comprehensive functionality. This package takes care of all the steps including scraping rental websites, processing the data, and emailing users with the updated listing information. Plenty of general scraper packages exist in the R ecosystem, but they lack the focus on house rental in Canada and emailing functionality, such as the following two: https://github.com/adletaw/craigr and https://github.com/jayfeng1/Craigslist-Pricing-Project. 



## Installation

- TODO

## Features

- TODO

## Dependencies

- TODO

## Usage

- TODO

## Documentation

- TODO

## Contributors

We welcome and recognize all contributions. You can see how to contribute [here](https://github.com/UBC-MDS/rhousehunter/blob/main/.github/CONTRIBUTING.md)

### Credits

This package was created with reference from `devtools` package and [R package guide](https://r-pkgs.org/index.html) by [Hadley Wickham](http://hadley.nz/) and [Jenny Bryan](https://jennybryan.org/)
