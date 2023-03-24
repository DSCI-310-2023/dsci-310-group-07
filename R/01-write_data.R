# author: Jiaying Liao
# date: 2023-03-08
# last update: 2023-03-21

#' Read and write the dataset into automobile.csv
#' Change the column names into more readable ones
#' Replace all the "?" by NAs

doc<-"
Usage:
  R/01-write_data.R --input_dir=<input_dir>  --out_dir=<output_dir> 
Options:
  --input_dir=<input_dir>		
  --out_dir=<output_dir>		
"


library(docopt)
library(tidyverse)

opt <- docopt(doc)

main <- function(input_dir, out_dir) {
  # Create out_dir if it does not exist
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }

names<-c("symboling","normalized-losses","make","fuel-type","aspiration",
         "num-of-doors","body-style","drive-wheels","engine-location",
         "wheel-base","length","width","height","curb-weight","engine-type",
         "num-of-cylinders","engine-size","fuel-system","bore","stroke",
         "compression-ratio","horsepower","peak-rpm","city-mpg","highway-mpg","price")

df<-read_csv(input_dir,
             col_names=names)
df <- replace(df, df == "?", NA)
write_csv(df, file.path(out_dir, "automobile.csv"))
rm(df)
rm(names)

}

main(opt[["--input_dir"]], opt[["--out_dir"]])

