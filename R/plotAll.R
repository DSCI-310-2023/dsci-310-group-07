# author: Xiwen Wei
# date: 2023-03-10

#' Show all the plots of the selected predictor variables
#'
#' For the numerical variables, we created both a histogram to see the distribution, 
#' and a scatterplot to see the relationship between the variable and the car price.
#' 
#' For the categorical variables, 
#' we created a bar graph to compare the count of each category in a variable.
#' 
#' @param data A dataframe
#' @param nms The names of our predictor variables
#'
#' @return All the plots
#'
#' @examples
#' plotAll(dataset, ["we", "are", "the", "best"])

plotAll <- function(data, nms, to_print = TRUE) {
  options(repr.plot.height = 3, repr.plot.width = 7)
  
  plots <- list()
  i <- 1
  
  for (x in 1:25){
    if (colnames(data[,x]) %in% nms){
      
      if (typeof(unlist(data[,x]))=="double"){
        plots[[i]]<-data %>%
                ggplot() +
                geom_histogram(aes(x = unlist(data[,x])), bins = 30)+
                xlab(colnames(data[,x]))
        if (to_print) {
          print(plots[[i]])
        }
        i <- i+1
        
        plots[[i]] <- data %>% 
                ggplot(aes(x = unlist(data[,x]),y=unlist(data[,26]))) +
                geom_point()+
                geom_smooth(method=lm,formula=y~x,se=FALSE)+
                xlab(colnames(data[,x]))+
                ylab("Car price (USD)")
        if (to_print) {
          print(plots[[i]])
        }
        i <- i+1
        }
      
      
      else{
        plots[[i]] <- data %>%
                ggplot(aes(x=unlist(data[,x]))) +
                geom_bar(stat="count",bins=30)+
                xlab(colnames(data[,x])) +
                theme(axis.text.x = element_text(angle = 40, hjust = 1))
        if (to_print) {
          print(plots[[i]])
        }
        
      }
      
      
    }
    
  }
  if (!to_print) {
    return(plots)
  }
  
}