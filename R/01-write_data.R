# author: Jiaying Liao
# date: 2023-03-08
# last update: 2023-03-21

library(docopt)
library(tidyverse)

#' Read and write the dataset into automobile.csv
#' Change the column names into more readable ones
#' Replace all the "?" by NAs

website <- "https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data"

doc<-"
Usage:
  R/01-write_data.R --input_dir=<input_dir>  --out_dir=<output_dir> 
Options:
  --input_dir=<input_dir>		[default: website]
  --out_dir=<output_dir>	[default: data]	
"
if (interactive()) {
  opt <- docopt(doc, args = commandArgs(trailingOnly = TRUE))
} else {
  opt <- list(input_dir = website,out_dir = "data")
}


opt <- docopt(doc)


main <- function(input_dir = website,
                 out_dir = "data") {
  # Create out_dir if it does not exist
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }
  
  names <-
    c("symboling",
      "normalized-losses",
      "make",
      "fuel-type",
      "aspiration",
      "num-of-doors",
      "body-style",
      "drive-wheels",
      "engine-location",
      "wheel-base",
      "length",
      "width",
      "height",
      "curb-weight",
      "engine-type",
      "num-of-cylinders",
      "engine-size",
      "fuel-system",
      "bore",
      "stroke",
      "compression-ratio",
      "horsepower",
      "peak-rpm",
      "city-mpg",
      "highway-mpg",
      "price")
  
  df <- read_csv(input_dir,
                 col_names = names)
  df <- replace(df, df == "?", NA)
  name <- "automobile.csv"
  write_csv(df, file.path(out_dir, name))
  # print if successfully wrote
  print(paste(name, "wrote to", out_dir, sep = " "))
  

}

main(opt$input_dir, opt$out_dir)

