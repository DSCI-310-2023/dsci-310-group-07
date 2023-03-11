library(testthat)
library(here)

source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))
source(here("R/showR2.R"))

expect_equal(nrow(showR2(automobile,8)), 8)
expect_equal(length(showR2(automobile,8)), 2)
