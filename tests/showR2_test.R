library(testthat)
library(here)

source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))
source(here("R/showR2.R"))

test_that("the result doesn't contains the correct number of rows",
         expect_equal(nrow(showR2(automobile,8)), 8))
test_that("the result doesn't contains the correct number of columns",
          expect_equal(ncol(showR2(automobile,8)), 2))
