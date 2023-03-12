# author: Haobo (Harbor) Zhang
# date: 2023-03-07

#' Take the given dataset, remove the last column.
#'    
#' @param dataset a dataset
#' 
#' @return the dataset without the last column
#' 
#' @examples
#' processdata(dat)
processdata <- function(dataset) {
  dataset[,-length(dataset)]
}
