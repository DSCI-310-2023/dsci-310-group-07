##author: Haobo(Harbor) Zhang
##date: 2023-03-11

## tests for processdata function

library(testthat)
library(here)

source(here("R/processdata.R"))
source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))

test_that("the last column is not correct",
          expect_equal(colnames(processdata(automobile)[,25]),"highway-mpg"))
test_that("the number of rows does not match",
          expect_equal(nrow(processdata(automobile)[,25]),205))

