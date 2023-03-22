#' author: Jiaying Liao
#' date: 2023-03-22
#' 
#' This R script performs cross-validation on the dataset, and the best model 
#' will be generated
#' 

library(tidyverse)
library(here)

source(here("R/get_model.R"))
source(here("R/make_kable.R"))
source(here("R/02-read_data.R"))

# generate the traning and testing sets from `get_trt_test()` function
tst<-get_tr_tst(automobile)
training_df<-get_tr_tst(automobile,"basic")[[1]]
testing_df<-get_tr_tst(automobile,"basic")[[2]] 
training_df_at<-get_tr_tst(automobile,"at")[[1]]
testing_df_at<-get_tr_tst(automobile,"at")[[2]]


