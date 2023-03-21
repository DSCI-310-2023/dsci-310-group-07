# author: Jiaying Liao
# date: 2023-03-08
# last update: 2023-03-21

#' Read and write the dataset into automobile.csv
#' Change the column names into more readable ones
#' Replace all the "?" by NAs

library(tidyverse)

names<-c("symboling","normalized-losses","make","fuel-type","aspiration",
         "num-of-doors","body-style","drive-wheels","engine-location",
         "wheel-base","length","width","height","curb-weight","engine-type",
         "num-of-cylinders","engine-size","fuel-system","bore","stroke",
         "compression-ratio","horsepower","peak-rpm","city-mpg","highway-mpg","price")


df<-read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data",
             col_names=names)
df <- replace(df, df == "?", NA)
write_csv(df, here("data/automobile.csv"))
rm(df)
rm(names)
