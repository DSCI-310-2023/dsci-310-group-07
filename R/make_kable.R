#author: Jiaying Liao
#date: 2023-03-21

library(tidyverse)
library(knitr)
library(kableExtra)

#' Turn a data.frame into Kable when knitting
#'
#' Take a dataframe and return a Kable object with captions. The digits can be standardized.
#'
#' @param kb a kable
#'
#' @return a kable object with styling
#'
#' @examples
#' make_kable(kable(automobile))

make_kable <- function(kb) {
  kb %>%
    kable_styling(bootstrap_options = c("striped","hover","condensed"),
                  full_width = F,
                  position = "center")
}
