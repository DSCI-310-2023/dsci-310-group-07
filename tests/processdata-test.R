library(testthat)

expect_equal(colnames(processdata(df)[,26]),"price")
expect_equal(nrow(processdata(df)[,26]),205)