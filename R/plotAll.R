plotAll <- function(data, nms) {
  
  for (x in 1:25){
    if (colnames(data[,x]) %in% nms){
      
      if (typeof(unlist(data[,x]))=="double"){
        print(data %>%
                ggplot() +
                geom_histogram(aes(x = unlist(data[,x])), bins = 30)+
                xlab(colnames(data[,x])))
        
        print(data %>% 
                ggplot(aes(x = unlist(data[,x]),y=unlist(data[,26]))) +
                geom_point()+
                geom_smooth(method=lm,formula=y~x,se=FALSE)+
                xlab(colnames(data[,x]))+
                ylab("Car price (USD)"))}
      
      else{
        print(data %>%
                ggplot(aes(x=unlist(data[,x]))) +
                geom_bar(stat="count",bins=30)+
                xlab(colnames(data[,x])) +
                theme(axis.text.x = element_text(angle = 40, hjust = 1)))
        
      }
      
    }
    
  }
  
}