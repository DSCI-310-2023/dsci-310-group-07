#'author: Jiaying Liao
#'date: 2023-03-22
#'
#'This R script will saves the plots for EDA analysis

library(tidyverse)
library(here)
library(cowplot)
library(testthat)

source(here("R/02-read_data.R"))
source(here("R/03-eda_tables.R"))
source(here("R/plotAll.R"))


# obtain plots from `plotAll` function
plots <- plotAll(automobile, nms)

# This will save the bar plot to figs

bar_idx <- c(1,8)
bar_names <- c("make.png","cld.png")

for (i in 1:2) {
  idx <- bar_idx[i]
  name <- bar_names[i]
  ggsave(name,
         plot = plots[[idx]],
         path = here("analysis/figs"),
         width = 5, height = 3)
}

# This will combine an histogram and scatterplot, and save it in figs
combine_idx <- c(2,4,6,9,11,13)
combine_names <- c("length.png","width.png","curb_weight.png",
                   "eg_size.png","horse_pw.png","hw_mpg.png")

for (i in 1:6) {
  idx <- combine_idx[i]
  name <- combine_names[i]
  ggsave(name,
         plot = plot_grid(plots[[idx]],plots[[idx+1]]),
         path = here("analysis/figs"),
         width = 6, height = 2.5)
  
}
