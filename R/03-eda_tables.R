#'author: Jiaying Liao
#'date: 2023-03-22
#'
#' This R script mainly prints the tables from section preliminary
#' analysis to exploratory analysis.



library(here)
library(tidyverse)
library(knitr)
library(kableExtra)

source(here("R/02-read_data.R"))
source(here("R/make_kable.R"))
source(here("R/showR2.R"))

# Preliminary Analysis
# print out the first 6 rows of `automobile` as kables
# the dataset will be split for being too long
left_automobile <- head(automobile[,1:13]) %>% 
  make_kable(cap = "Row 1 to 6, Column 1 to 13 in Automobile Dataset",
             digit = 3)
right_automobile <- head(automobile[,14:26]) %>% 
  make_kable(cap = "Row 1 to 6, Column 14 to 26 in Automobile Dataset",
             digit = 3)

# summary of automobile
options(knitr.kable.NA = '')
summary_automobile <- summary(automobile) %>% 
  t() %>%
  make_kable(cap = "Summary of Automobile",digit = 4)

# The first 8 variables that explain most variations in price
top8 <- showR2(automobile, 8)
colnames(top8)[1] <- "R^2"
top8_output <- top8 %>%
  make_kable(cap = "The 8 variables with highest R^2", digit = 4)

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

# kable for levels_all
levels_kb <- levels_all %>%
  make_kable(cap = "Levels of all variables", digit = 1)
