# author: Ning Wang
# date: 2023-03-08

##dropping non-use variables
##split data into training and testing
##remove ID variables

##get testing set and training set with out id

##get testing set and training set with id

##get testing set and training set for ridge and lasso model

library(glmnet)

get_tr_tst<-function(automobile,set="at"){
  set.seed(123)
  
  #dropping engine-location variable
  drop <- "engine-location"
  df_no_eng_loc <-automobile[,!(names(automobile) %in% drop)]
  
  
  #dropping ? level in num-of-doors
  df_no_eng_loc$`num-of-doors`<-as.character(df_no_eng_loc$`num-of-doors`)
  
  clean_automobile <-df_no_eng_loc%>%filter(`num-of-doors`!='?')%>%na.omit()
  
  clean_automobile$`num-of-doors`<-as.factor(clean_automobile$`num-of-doors`)
  
  #split data into training and testing
  clean_automobile$ID <- 1:nrow(clean_automobile)
  training_df <- sample_n(clean_automobile, size = nrow(clean_automobile) * 0.70,
                          replace = FALSE
  )
  
  testing_df <- anti_join(clean_automobile,
                          training_df,
                          by = "ID"
  )
  
  #remove ID variables
  training_df_at <- training_df[,-26]
  testing_df_at <- testing_df [,-26]
  
  drops <- c("symboling","make","body-style","drive-wheels","engine-type","num-of-cylinders","fuel-system")
  training_df_sub<-training_df_at[,!(names(training_df_at) %in% drops)]
  testing_df_sub<-testing_df_at[,!(names(testing_df_at) %in% drops)]
  
  
  
  if (set=="at"){
    
    return(list(training_df_at,testing_df_at))
    
  }
  
  else if (set=="basic"){
    
    return(list(training_df,testing_df))
  }
  
  else if (set=="sub"){
    return(list(training_df_sub,testing_df_sub))
  }
  
  
  else{
    
    warning("invalid input")
  }
  
}

###Purpose:
##get training and testing matrix for x,y for lasso and ridge models
##split training and test in to x matrix and y matrix


get_trm_tsm<-function(training_df_sub,testing_df_sub,set="training"){
  
  #training matrix
  x_train_mat <-model.matrix( ~ ., training_df_sub[,-18])
  y_train_mat <-training_df_sub$price
  
  #testing matrix
  x_test_mat <-model.matrix( ~ ., testing_df_sub[,-18])
  y_test_mat <-testing_df_sub$price
  
  if (set=="training"){
    return(list(x_train_mat,y_train_mat))
  }
  
  else if (set=="testing"){
    return(list(x_test_mat,y_test_mat))
  }
  
  else{
    warning("invalid input")
  }
}


###purpose:
## get models or plots for lasso or ridge
get_model_plot <- function(x_train_mat, y_train_mat, model = "lasso", ask = "modeling") {
  set.seed(123)
  if (model == "lasso") {
    lasso_cv <- cv.glmnet(x = x_train_mat, y = y_train_mat, alpha = 1, nfolds = 10)
    if (ask == "plot") {
      plot(lasso_cv, main = "MSE of LASSO estimated by CV for different lambdas\n\n")
    } 
    else if (ask == "modeling") {
      lasso_mod <- glmnet(x = x_train_mat, y = y_train_mat, alpha = 1, lambda = lasso_cv$lambda.min)
      lasso_mod_1se <- glmnet(x = x_train_mat, y = y_train_mat, alpha = 1, lambda = lasso_cv$lambda.1se)
      return(list(lasso_mod, lasso_mod_1se, lasso_cv))
    } 
    else {
      warning("ask should be modeling or plot")
    }
  } 
  else if (model == "ridge") {
    ridge_cv <- cv.glmnet(x = x_train_mat, y = y_train_mat, alpha = 0, nfolds = 10)
    if (ask == "plot") {
      plot(ridge_cv, main = "MSE of Ridge estimated by CV for different lambdas\n\n")
    } 
    else if (ask == "modeling") {
      ridge_mod <- glmnet(x = x_train_mat, y = y_train_mat, alpha = 0, lambda = ridge_cv$lambda.min)
      ridge_mod_1se <- glmnet(x = x_train_mat, y = y_train_mat, alpha = 0, lambda = ridge_cv$lambda.1se)
      return(list(ridge_mod, ridge_mod_1se, ridge_cv))
    } 
    else {
      warning("ask should be modeling or plot")
    }
  } 
  else {
    warning("model should be lasso or ridge")
  }
}


###purpose:
## get rmse for the lasso minimum rmse, ridge minimum rmse, lasso 1se rmse,
## ridge 1se rmse and ols rmse
get_er_cv<-function(training_df_at,training_df_sub,kfolds=10,lasso_cv,ridge_cv){
  set.seed(123)
  
  fold_labels <- sample(rep(seq(kfolds), length.out = nrow(training_df_sub)))
  errors <- matrix(NA,ncol=5,nrow=10)
  for (fold in seq_len(kfolds)) {
    test_rows <- fold_labels == fold
    train <- training_df_sub[!test_rows, ]
    test <- training_df_sub[test_rows, ]
    
    #since the matrix size for LASSO and Ridge is different from OLS, we will be using different training and testing sets for OLS
    train_ols <- training_df_at[!test_rows, ]
    test_ols <- training_df_at[test_rows, ]
    
    x_train_mat<-model.matrix( ~ ., train[,-18])
    y_train_mat<-train$price
    
    x_test_mat<-model.matrix( ~ ., test[,-18])
    y_test_mat<-test$price
    
    # We fit the LASSO and Ridge regression models using lambda values found using cross-validation. 
    mod_lasso_min <- glmnet(x=x_train_mat,y=y_train_mat,alpha=1,lambda=lasso_cv$lambda.min)
    
    mod_lasso_1se <- glmnet(x=x_train_mat,y=y_train_mat,alpha=1,lambda=lasso_cv$lambda.1se)
    
    ridge_mod_min<-glmnet(x=x_train_mat,y=y_train_mat,alpha=0,lambda=ridge_cv$lambda.min)
    
    ridge_mod_1se<-glmnet(x=x_train_mat,y=y_train_mat,alpha=0,lambda=ridge_cv$lambda.1se)
    
    
    #There is a slight issue with the variable `make`, it has new levels in new folds,
    #and the OLS model cannot perform the OLS function in the k-folds cross validation; 
    #the variable has been removed in order to successfully create our training and testing sets for our OLS model. 
    
    #building a matrix for the training set
    ols_x_red_train<-train_ols%>%as.data.frame()%>%dplyr::select(symboling , `normalized-losses` , make , 
                                                                 `fuel-type` , aspiration , `num-of-doors` , `body-style` , 
                                                                 `drive-wheels` , `wheel-base` , length , width , height , 
                                                                 `curb-weight` , `engine-type` , `num-of-cylinders` , `engine-size` , 
                                                                 `fuel-system` , bore ,stroke , `compression-ratio` , horsepower , 
                                                                 `peak-rpm` , `city-mpg` , `highway-mpg`)
    
    ols_x_mat_train<-model.matrix(~.,ols_x_red_train)
    
    #building a matrix for the testing set
    ols_x_red_test<-test_ols%>%as.data.frame()%>%dplyr::select(symboling , `normalized-losses` , make , 
                                                               `fuel-type` , aspiration , `num-of-doors` , `body-style` , 
                                                               `drive-wheels` , `wheel-base` , length , width , height , 
                                                               `curb-weight` , `engine-type` , `num-of-cylinders` , `engine-size` , 
                                                               `fuel-system` , bore , stroke , `compression-ratio` , horsepower , 
                                                               `peak-rpm` , `city-mpg` , `highway-mpg`)
    
    ols_x_mat_test<-model.matrix(~.,ols_x_red_test)
    
    # we know that when lambda = 0 and alpha=1, the glmnet() performs the same as lm
    ols_fs<- glmnet(x=ols_x_mat_train,y=y_train_mat,alpha=1,lambda=0)
    
    
    #compute the cross-validation RMSE
    preds_1<-predict(mod_lasso_min,x_test_mat)
    preds_2<-predict(mod_lasso_1se,x_test_mat)
    preds_3<-predict(ridge_mod_min,x_test_mat)
    preds_4<-predict(ridge_mod_1se,x_test_mat)
    preds_5<-predict(ols_fs,ols_x_mat_test)
    
    errors[fold,1] <- sqrt(mean(y_test_mat-preds_1)^2)
    errors[fold,2] <- sqrt(mean(y_test_mat-preds_2)^2)
    errors[fold,3] <- sqrt(mean(y_test_mat-preds_3)^2)
    errors[fold,4] <- sqrt(mean(y_test_mat-preds_4)^2)
    errors[fold,5] <- sqrt(mean(y_test_mat-preds_5)^2)
  }
  
  return(tibble(
    Model = c("LASSO Regression with minimum MSE", "LASSO Regression with 1SE MSE", "Ridge Regression with minimum MSE", "LASSO Regression with 1SE MSE", "OLS Full Regression"), 
    R_MSE = c(mean(errors[, 1]), mean(errors[, 2]), mean(errors[, 3]), mean(errors[, 4]), mean(errors[, 5]))))
}
