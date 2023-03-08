# author: Haobo (Harbor) Zhang
# date: 2023-03-07

## take the given dataset, remove the last column and the missing values.

processdata <- function(dataset) {
  df = dataset[,-length(dataset)] %>%
    na.omit(dataset)
}