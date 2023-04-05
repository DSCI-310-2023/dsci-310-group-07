#' author: Jiaying Liao
#' date: 2023-03-22
#' 
#' This R script performs cross-validation on the dataset, and the best model 
#' will be generated
#' 

# libraries
library(docopt)
library(tidyverse)
library(here)
# function
source(here("R/get_model.R"))
# variable
automobile <- readRDS(here("analysis/vars/automobile.rds"))



doc <- "
Usage:
  R/05-train_models.R [--out_dir=<output_dir>]
Options:
  --out_dir=<output_dir>  [default: data]
"

if (length(commandArgs(trailingOnly = TRUE)) > 0) {
  opt <- docopt(doc, args = commandArgs(trailingOnly = TRUE))
} else {
  opt <- list(out_dir = "data")
}

# generate the traning and testing sets from `get_trt_test()` function
tst<-get_tr_tst(automobile)

training_df<-get_tr_tst(automobile,"basic")[[1]]
testing_df<-get_tr_tst(automobile,"basic")[[2]] 

training_df_at<-get_tr_tst(automobile,"at")[[1]]
testing_df_at<-get_tr_tst(automobile,"at")[[2]]

training_df_sub<-get_tr_tst(automobile,"sub")[[1]]
testing_df_sub<-get_tr_tst(automobile,"sub")[[2]] 

# prepare x, y matrice for lasso and ridge regression
x_train_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="training")[[1]]
y_train_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="training")[[2]]
x_test_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="testing")[[1]]
y_test_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="testing")[[2]]

# Lasso regression
## model
lasso_mods<-get_model_plot(x_train_mat,y_train_mat,model="lasso",ask="modeling")
lasso_mod<-lasso_mods[[1]]
lasso_mod_1se<-lasso_mods[[2]]

# Ridge regression
## model
ridge_mods<-get_model_plot(x_train_mat,y_train_mat,model="ridge",ask="modeling")
ridge_mod<-ridge_mods[[1]]
ridge_mod_1se<-ridge_mods[[2]]

# Training result 
lasso_cv<-get_model_plot(x_train_mat,y_train_mat,model="lasso",ask="modeling")[[3]]
ridge_cv<-get_model_plot(x_train_mat,y_train_mat,model="ridge",ask="modeling")[[3]]

cv_result <- get_er_cv(training_df_at,training_df_sub,kfolds=10,lasso_cv,ridge_cv) 

# Prediction error of best model
preds <- predict(lasso_mod_1se,x_test_mat)
err <- sqrt(mean(y_test_mat-preds)^2)

# Kept variables of the best model
coef_mat<-coef(lasso_mod_1se)

summs <- summary(coef_mat)

kept <- data.frame(kept_variables = rownames(coef_mat)[summs$i],
           coefficient = summs$x) 

## adding the initial value to forbid the error when the other files call this
## r file
main <- function(out_dir="data") {
  # Create out_dir if it does not exist
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }
  name <- "kept.csv"
  write_csv(kept, file.path(out_dir, name))
  # print if successfully wrote
  print(paste(name, "wrote to", out_dir, sep = " "))
}

main(opt$out_dir)