##author: Haobo(Harbor) Zhang
##date: 2023-03-11

## tests for processdata function

library(testthat)
library(here)

source(here("R/processdata.R"))

expect_equal(colnames(processdata(df)[,26]),"price")
expect_equal(nrow(processdata(df)[,26]),205)
