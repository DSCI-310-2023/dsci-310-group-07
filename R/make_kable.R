#author: Jiaying Liao
#date: 2023-03-21

library(tidyverse)
library(knitr)
library(kableExtra)

#' Turn a data.frame into Kable when knitting
#'
#' Take a dataframe and return a Kable object with captions. The digits can be standardized.
#'
#' @param df a data.frame
#' @param cap caption, which is a string
#' @param digit the number of digit
#'
#' @return a kable object with styling
#'
#' @examples
#' make_kable(automobile, "Automobile Dataset", 3)

make_kable <- function(df, cap, digit) {
  df %>%
    kable(digits = digit,
          caption = cap) %>%
    kable_styling(bootstrap_options = c("striped","hover","condensed"),
                  full_width = F,
                  position = "center")
  
}
