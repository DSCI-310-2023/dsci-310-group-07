library(tidyverse)
library(testthat)
library(here)
source(here("R/make_kable.R"))

# Generate a small data frame for testing
small_df <- data.frame(
  type = factor(c("A", "B", "C", "B", "A")),
  age = c(25, 30, 45, 60, 10),
  score = c(80.98962, 60, 95, 75, 40)
)

# Output of make_kable function
small_kable <- small_df %>%
  make_kable("a caption", 2) 

# The expected result, a kable
expected_kable <- small_df %>%
  kable(digits = 2,
        caption = "a caption") %>%
  kable_styling(bootstrap_options = c("striped","hover","condensed"),
                full_width = F,
                position = "center")

# Tests
expect_equivalent(small_kable,expected_kable)
