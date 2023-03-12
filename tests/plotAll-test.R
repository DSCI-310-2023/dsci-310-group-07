# author: Jiaying Liao
# date: 2023-03-12

library(ggcheck)
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
plots <- plotAll(automobile,names,FALSE)

# tests
expect_equal(length(plots), 12)
expect_true(uses_geoms(plots[[1]], 
                       c("histogram"), 
                       exact = FALSE))
expect_true(uses_geoms(plots[[2]], 
                       c("point", "smooth"), 
                       exact = FALSE))
