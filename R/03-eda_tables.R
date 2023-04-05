#'author: Jiaying Liao
#'date: 2023-03-22
#'
#' This R script mainly prints the tables from section preliminary
#' analysis to exploratory analysis.



library(here)
library(tidyverse)
library(knitr)
library(kableExtra)
library(docopt)

# get automobile dataframe
automobile <- readRDS(here("analysis/vars/automobile.rds"))

source(here("R/showR2.R"))
source(here("R/saveVar.R"))

doc<-"
Usage:
  R/03-eda_tables.R --out_dir=<output_dir> 
Options:
  --out_dir=<output_dir> [default: data]
"
if (interactive()) {
  opt <- docopt(doc, args = commandArgs(trailingOnly = TRUE))
} else {
  opt <- list(out_dir = "data")
}

# Preliminary Analysis

# The first 8 variables that explain most variations in price
top8 <- showR2(automobile, 8)
colnames(top8)[1] <- "R^2"
saveVar(top8,"top8.rds", here("analysis/vars"))

# Top 8 variables' names
nms <- pull(top8,names)
saveVar(nms,"nms.rds", here("analysis/vars"))


# Levels of all variables without na
levels_all <- data.frame(num_unique = sapply(lapply(na.omit(automobile), unique), length),
                         type = sapply(automobile, class))  

# The variables that are factors with more than 2 levels
mul_lvl_fct <- data.frame(variable = colnames(automobile),
                          levels_all) %>%
  mutate(mul_lvl = ((type == "factor") & (num_unique > 2))) %>%
  filter(mul_lvl) %>%
  pull(variable)
saveVar(mul_lvl_fct,"mul_lvl_fct.rds", here("analysis/vars"))

## adding the initial value to forbid the error when the other files call this
## r file
main <- function(out_dir = "data") {
  # Create out_dir if it does not exist
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }
  name <- "levels.csv"
  write_csv(levels_all, file.path(out_dir, name))
  # print if successfully wrote
  print(paste(name, "wrote to", out_dir, sep = " "))
}

main(opt$out_dir)

