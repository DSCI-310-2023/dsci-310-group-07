##author: Haobo(Harbor) Zhang
##date: 2023-03-11

## tests for processdata function

library(testthat)

expect_equal(colnames(processdata(df)[,26]),"price")
expect_equal(nrow(processdata(df)[,26]),205)
