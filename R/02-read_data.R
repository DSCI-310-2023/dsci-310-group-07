# author: Jiaying Liao
# date: 2023-03-08
# last update: 2023-03-21

#' Read the automobile dataset from csv and store as variable `automobile`
#' Change the column types based on the values

library(tidyverse)
library(here)
source(here("R/saveVar.R"))

automobile <- read_csv(
  here("data/automobile.csv"),
  col_types = cols(
    symboling = col_factor(),
    `normalized-losses` = col_double(),
    make = col_factor(),
    `fuel-type` = col_factor(),
    aspiration = col_factor(),
    `num-of-doors` = col_factor(),
    `body-style` = col_factor(),
    `drive-wheels` = col_factor(),
    `engine-location` = col_factor(),
    `wheel-base` = col_double(),
    length = col_double(),
    width = col_double(),
    `curb-weight` = col_double(),
    `engine-type` = col_factor(),
    `num-of-cylinders` = col_factor(),
    `engine-size` = col_double(),
    `fuel-system` = col_factor(),
    bore = col_double(),
    stroke = col_double(),
    `compression-ratio` = col_double(),
    horsepower = col_double(),
    `peak-rpm` = col_double(),
    `city-mpg` = col_double(),
    `highway-mpg` = col_double(),
    price = col_double()
  )
)

# Save variable to vars
saveVar(automobile,"automobile.rds", here("analysis/vars"))


