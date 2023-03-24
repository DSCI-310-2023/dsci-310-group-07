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

source(here("R/02-read_data.R"))
source(here("R/showR2.R"))

doc<-"
Usage:
  R/01-write_data.R --out_dir=<output_dir> 
Options:
  --out_dir=<output_dir>		
"
opt <- docopt(doc)
main <- function(out_dir) {
  # Create out_dir if it does not exist
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }
# Preliminary Analysis
# print out the first 6 rows of `automobile` as kables
# the dataset will be split for being too long
left_automobile <- head(automobile[,1:13]) 
right_automobile <- head(automobile[,14:26]) 

# summary of automobile
summary_automobile <- summary(automobile) %>% 
  t() 

# The first 8 variables that explain most variations in price
top8 <- showR2(automobile, 8)
colnames(top8)[1] <- "R^2"


# Top 8 variables' names
nms <- pull(top8,names)

# Levels of all variables without na
levels_all <- data.frame(num_unique = sapply(lapply(na.omit(automobile), unique), length),
                         type = sapply(automobile, class))  

# The variables that are factors with more than 2 levels
mul_lvl_fct <- data.frame(variable = colnames(automobile),
                          levels_all) %>%
  mutate(mul_lvl = ((type == "factor") & (num_unique > 2))) %>%
  filter(mul_lvl) %>%
  pull(variable)

write_csv(levels_all, file.path(out_dir, "levels.csv"))
}

main(opt[["--out_dir"]])

