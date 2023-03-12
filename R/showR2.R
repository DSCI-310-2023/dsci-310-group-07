# author: Xiwen Wei
# date: 2023-03-10

#' Show the summary table of top n highest R^2 values
#'
#' Print out the R^2 (coefficient of determination) of all the variables and store it in <r_sqr>
#' 
#' Remove the price variable (response) and store other variables' name in <names>
#' 
#' Create a summary table of the predictor variables with the top n highest R^2 values
#' 
#' @param data A dataframe
#' @param n The numbers of variables
#'
#' @return A summary table of R^2
#'
#' @examples
#' showR2(dataset, 10)

showR2 <- function(data, n) {
  
  r_sqr<-c()
  for (x in 1:25){
    r_sqr<-c(r_sqr,summary(lm(unlist(data[,26])~unlist(data[,x])))$r.squared)
    
  }
  
  names<-colnames(data[,-26])
  
  df_sqr<-cbind(r_sqr,names)%>%as.data.frame()
  df_sqr$r_sqr<-as.numeric(df_sqr$r_sqr)
  head(df_sqr%>%arrange(desc(df_sqr$r_sqr)),n)
  
}


