# author: Jiaying Liao
# date: 2023-03-12
# update on: 2023-03-23

library(here)
library(testthat)
library(ggcheck)
source(here("R/plotALL.R"))
source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))

# Tests for `get_*`
x <- c(1:5,2:5,4:7)
y <- c(1,2,3,4,5,6,7,8,9,10,11,12,13)
dat <- data.frame(x,y)

# get_hist
expect_true(uses_geoms(get_hist(x,"random"),
                       geoms = "histogram"))
# get_hist
expect_true(uses_geoms(get_scatter(x, y,"random"),
                       c("point", "smooth")))
# get_bar
expect_true(uses_geoms(get_bar(x,"random"),
                       geoms = "bar"))

# Tests for plotAll
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


