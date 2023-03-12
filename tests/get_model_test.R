# author: Ning Wang
# date: 2023-03-11

library(testthat)
library(here)
library(tidyverse)

source(here("R/get_model.R"))
source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))
source(here("R/generate_tiny_dat.R"))
options(warn=-1)
##small data fit model might cause warning


# expect_equal(nrow(get_tr_tst(automobile,"at")[[1]]),14)

df<-generate_tiny_dat(automobile)
df

# tests for get_tr_tst()
# sample_n may cause rounding
expect_equal(
  nrow(get_tr_tst(df, "at")[[1]]) %in% c(nrow(df)*0.7, nrow(df)*0.7-1),
  TRUE
)
expect_equal(nrow(get_tr_tst(df,"at")[[2]]),nrow(df)*0.3)

expect_equal(
  nrow(get_tr_tst(df, "sub")[[1]]) %in% c(nrow(df)*0.7, nrow(df)*0.7-1),
  TRUE
)
expect_equal(nrow(get_tr_tst(df,"sub")[[2]]),nrow(df)*0.3)

expect_equal(
  nrow(get_tr_tst(df, "basic")[[1]]) %in% c(nrow(df)*0.7, nrow(df)*0.7-1),
  TRUE
)
expect_equal(nrow(get_tr_tst(df,"basic")[[2]]),nrow(df)*0.3)


expect_warning(get_tr_tst(df, "other"), "invalid input")


# tests for get_trm_tsm()
#y matrix is only one vector get_trm_tsm(), where ncol=NULL
training_df_sub<-get_tr_tst(df,"sub")[[1]]
testing_df_sub<-get_tr_tst(df,"sub")[[2]] 
training_df<-get_tr_tst(df,"basic")[[1]]
testing_df<-get_tr_tst(df,"basic")[[2]] 
training_df_at<-get_tr_tst(df,"at")[[1]]
testing_df_at<-get_tr_tst(df,"at")[[2]]


expect_equal(ncol(get_trm_tsm(training_df_sub,testing_df_sub,set="training")[[1]]),
             19)

expect_equal(ncol(get_trm_tsm(training_df_sub,testing_df_sub,set="training")[[2]]),
             NULL)

expect_equal(ncol(get_trm_tsm(training_df_sub,testing_df_sub,set="testing")[[1]]),
             19)

expect_equal(ncol(get_trm_tsm(training_df_sub,testing_df_sub,set="testing")[[2]]),
             NULL)

# tests for get_model_plot()
x_train_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="training")[[1]]
y_train_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="training")[[2]]
x_test_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="testing")[[1]]
y_test_mat<-get_trm_tsm(training_df_sub,testing_df_sub,set="testing")[[2]]


expect_true("glmnet" %in% 
              class(get_model_plot(x_train_mat, y_train_mat,
                                   model = "lasso", ask = "modeling")[[1]]))

expect_true("glmnet" %in% 
              class(get_model_plot(x_train_mat, y_train_mat,
                                   model = "lasso", ask = "modeling")[[2]]))

expect_true("cv.glmnet" %in% 
              class(get_model_plot(x_train_mat, y_train_mat,
                                   model = "lasso", ask = "modeling")[[3]]))

expect_true("glmnet" %in% 
              class(get_model_plot(x_train_mat, y_train_mat,
                                   model = "ridge", ask = "modeling")[[1]]))

expect_true("glmnet" %in% 
              class(get_model_plot(x_train_mat, y_train_mat,
                                   model = "ridge", ask = "modeling")[[2]]))

expect_true("cv.glmnet" %in% 
              class(get_model_plot(x_train_mat, y_train_mat,
                                   model = "ridge", ask = "modeling")[[3]]))

expect_true({
  tryCatch({
    get_model_plot(x_train_mat, y_train_mat,
                   model = "ridge", ask = "plot")
    TRUE
  }, error = function(e) {
    FALSE
  })
})

expect_true({
  tryCatch({
    get_model_plot(x_train_mat, y_train_mat,
                   model = "lasso", ask = "plot")
    TRUE
  }, error = function(e) {
    FALSE
  })
})


expect_warning(get_model_plot(x_train_mat, y_train_mat,
                              model = "random forest", ask = "modeling"),
               "model should be lasso or ridge")

expect_warning(get_model_plot(x_train_mat, y_train_mat,
                              model = "ridge", ask = "modeling and plots"),
               "ask should be modeling or plot")



# tests for get_er_cv

lasso_cv<-get_model_plot(x_train_mat,y_train_mat,model="lasso",ask="modeling")[[3]]
ridge_cv<-get_model_plot(x_train_mat,y_train_mat,model="ridge",ask="modeling")[[3]]

test_that("get_er_cv returns the expected outputs", {
  output <- get_er_cv(training_df_at, training_df_sub, kfolds = 10, lasso_cv,ridge_cv)
  expect_equal(nrow(output), 5)
  expect_equal(ncol(output), 2)
  expect_equal(colnames(output), c("Model", "R_MSE"))
})

