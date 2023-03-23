# author: Xiwen Wei, Jiaying Liao
# date: 2023-03-10
# last update: 2023-03-23

library(testthat)
library(here)

source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))
source(here("R/showR2.R"))

# generate a small dataframe
x1 <- rep(0,10)  
x2 <- 1:10   
y <- 2*x2
test_df <- data.frame(x1,x2,y)

# the response variable y = 2*x2, a perfect fit. 
# the output must only contain `x2` and the r_sqr must be 1.
fn_out <- showR2(test_df,1)

# test the dimension
test_that("the result doesn't contain the correct number of rows",
          expect_equal(nrow(fn_out), 1))
test_that("the result doesn't contain the correct number of columns",
          expect_equal(ncol(fn_out), 2))
# test content
test_that("the expected R^2 is not correct (should be 1)",
          expect_equal(fn_out[1][1] %>% pull(),'1'))
test_that("the expected variable name is not correct (should be x2)",
          expect_equal(fn_out[2][1] %>% pull(),'x2'))

# simple tests for the dimension of output that is used in the report
test_that("the result doesn't contain the correct number of rows",
         expect_equal(nrow(showR2(automobile,8)), 8))
test_that("the result doesn't contain the correct number of columns",
          expect_equal(ncol(showR2(automobile,8)), 2))

