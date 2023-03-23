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
  if (nrow(dataset) == 0) {
    print("Need a non-empty dataset!")  ## handling empty-dataset case
  }else {
    dataset[,-length(dataset)]
  }
}
