# author: Jiaying Liao
# date: 2023-03-12

library(here)
library(testthat)
source(here("R/plotALL.R"))
source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))

names <-
  c(
    "make",
    "engine-size",
    "curb-weight" ,
    "horsepower",
    "num-of-cylinders",
    "width" ,
    "highway-mpg",
    "length"
  )

# get the plots from plotALL function
plots <- plotAll(automobile,names)

# tests
test_that("The function doesn't produce the correct number of plots",
          expect_equal(length(plots), 14))

test_that("The x-axis is not make",
          expect_equal(plots[[1]]$labels[1][1]$x,"make"))

test_that("The x-axis is not length",
          expect_equal(plots[[2]]$labels[1][1]$x,"length"))


