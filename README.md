# R House Hunter 


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

Please install package `devtools` and *rJava* before installing `rhousehunter`

```r
install.packages("devtools")
devtools::install_github("UBC-MDS/Rhousehunter")
```

*To get rJava, please need to install java (jdk8) from https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html*

## Features

The pyhousehunter package contains the following four functions:
- `scraper()`
The scraper function will scrape all listings available on a given craigslist housing url (e.g. https://vancouver.craigslist.org/d/apartments-housing-for-rent/search/apa).
- `data_cleaner()` 
The data_cleaner function will transform raw data from scraper() to a cleaned tibble object containing the scraped information.
- `data_filter()`
The data_filter function will filter the cleaned tibble based on the user's specifications. Users can specify their price range, minimum size, number of bedrooms, bathrooms, and desired municipality.
- `send_email()`
The send_email function sends end-users housing listing records meeting their specifications in a .csv format. The user must specify a valid email address and has the option to change the email subject.

## Dependencies

- polite
- rvest
- tibble
- xml2
- testthat
- dplyr
- stringr
- httr,
- readr
- knitr
- rJava


## Usage

Please refer to [the package vignette](https://github.com/UBC-MDS/Rhousehunter) for more details

## Documentation

The official documentation is hosted [here](https://github.com/UBC-MDS/Rhousehunter)

## Contributors

We welcome and recognize all contributions. You can see how to contribute [here](https://github.com/UBC-MDS/rhousehunter/blob/main/.github/CONTRIBUTING.md)

### Credits

This package was created with reference from `devtools` package, [R package guide](https://r-pkgs.org/index.html) by [Hadley Wickham](http://hadley.nz/) and [Jenny Bryan](https://jennybryan.org/) and [`polite` package](https://github.com/dmi3kno/polite) by [
Dmytro Perepolkin](https://github.com/dmi3kno)


