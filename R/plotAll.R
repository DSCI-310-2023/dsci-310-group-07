# author: Xiwen Wei, Jiaying Liao
# date: 2023-03-10
# update on: 2023-03-22


library(tidyverse)
library(here)
source(here("R/02-read_data.R"))
source(here("R/03-eda_tables.R"))

#' create histogram
#'
#' create histogram for a vector
#' 
#' @param x_val A vector of doubles
#' @param name the label of x_val
#'
#' @return a histogram
#'
#' @examples
#' get_hist(rnorm(10),"num")
get_hist <- function(x_val, name) {
  df <- data.frame(x = x_val)  
  ggplot(df, aes(x = x)) +    
    geom_histogram(bins = 30) +
    xlab(name)
}

#' create scatter plot
#'
#' create scatter plot where y vs x, where y is the price
#' the linear regresion line will also be generated
#' 
#' @param x_val A vector of doubles
#' @param y_val A vector of doubles, must has the same size as x_val
#' @param name the label of x_val
#'
#' @return a scatter plot
#'
#' @examples
#' get_scatter(rnorm(10),rnorm(10),"num")
get_scatter <- function(x_val, y_val, name) {
  df <- data.frame(x_ = x_val, y_ = y_val)
  df %>%
    ggplot(aes(x = x_, y = y_)) +
    geom_point() +
    geom_smooth(method = lm,
                formula = y ~ x,
                se = FALSE) +
    xlab(name) +
    ylab("Car price (USD)")
}

#' create bar plot
#'
#' create a bar plot for x, with a given lable on x axis
#' 
#' @param x_val A vector of factor/integer
#' @param name the label of x_val
#'
#' @return a bar plot
#'
#' @examples
#' get_bar(c("a","b","a"),"type")
get_bar <- function(x_val, name) {
  df <- data.frame(x_ = x_val)
  df %>%
    ggplot(aes(x = x_)) +
    geom_bar(stat = "count") +
    xlab(name) +
    theme(axis.text.x = element_text(angle = 40, hjust = 1))
}

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
plotAll <- function(data, nms) {
  plots <- list()
  i <- 1
  price <- unlist(data[, 26])
  
  for (x in 1:25) {
    var_name <- colnames(data[, x]) # name of the variable
    if (var_name %in% nms) {
      # plot/plots will be generate for this variable
      values <- unlist(data[, x]) # values of the variable
      
      if (typeof(values) == "double") {
        # variable type is double: 
        #   histogram:
        plots[[i]] <- get_hist(values,var_name)
        i <- i + 1
        #   scatter plot
        plots[[i]] <- get_scatter(values,price,var_name)
        i <- i + 1
      }
      else{
        # variable type is factor:
        #   bar plot
        plots[[i]] <- get_bar(values,var_name)
        i <- i+1
      }
    }
  }
  return(plots)
}
