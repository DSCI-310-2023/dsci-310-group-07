showR2 <- function(data, n) {
  
  #print out the R^2 (coefficient of determination) of all the variables
  r_sqr<-c()
  for (x in 1:25){
    r_sqr<-c(r_sqr,summary(lm(unlist(data[,26])~unlist(data[,x])))$r.squared)
    
  }
  
  #removes the price variable (response) since we are not calculating the R^2 of it.  
  names<-colnames(data[,-26])
  
  #create a summary table of the predictor variables with the top n highest R^2 values
  df_sqr<-cbind(r_sqr,names)%>%as.data.frame()
  df_sqr$r_sqr<-as.numeric(df_sqr$r_sqr)
  head(df_sqr%>%arrange(desc(df_sqr$r_sqr)),n)
  
}