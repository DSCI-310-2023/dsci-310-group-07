# author: Jiaying Liao
# Date: 2023-03-09


#' Generate Small Dataset for Testing Purpose
#'
#' If the dataset has less than 20 rows after removing NAs,
#' return the dataset with NAs
#' Otherwise, return the first 20 rows without NAs
#'
#' @param dat A dataframe
#'
#' @return A small dataframe
#'
#' @examples
#' generate_tiny_dat(dataset)

generate_tiny_dat <- function(dat) {
  dat <- dat %>% na.omit()
  if (nrow(dat <= 20)) {
    return(dat)
  } else {
    return(dat %>% head(20))
  }
}

