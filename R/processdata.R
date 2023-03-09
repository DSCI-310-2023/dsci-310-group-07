# author: Haobo (Harbor) Zhang
# date: 2023-03-07

## take the given dataset, remove the last column.

processdata <- function(dataset) {
  dataset[,-length(dataset)]
}
