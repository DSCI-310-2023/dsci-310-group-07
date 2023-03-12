##author: Haobo(Harbor) Zhang
##date: 2023-03-11

## tests for processdata function

library(testthat)
library(here)

source(here("R/processdata.R"))
source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))

expect_equal(colnames(processdata(automobile)[,25]),"highway-mpg")
expect_equal(nrow(processdata(automobile)[,25]),205)
