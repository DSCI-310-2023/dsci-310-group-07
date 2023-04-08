#'author: Jiaying Liao
#'date: 2023-03-22
#'
#'This R script will saves the plots for EDA analysis

library(tidyverse)
library(here)
library(cowplot)
library(carpriceprediction)


# get variables
automobile <- readRDS(here("analysis/vars/automobile.rds"))
nms <- readRDS(here("analysis/vars/nms.rds"))

# obtain plots from `plotAll` function
plots <- plotAll(automobile, nms)

# create dir if not exists
out_dir <- here("analysis/figs")
if (!dir.exists(out_dir)) {
  dir.create(out_dir)
}

# This will save the bar plot to figs

bar_idx <- c(1,8)
bar_names <- c("make.png","cld.png")

for (i in 1:2) {
  idx <- bar_idx[i]
  name <- bar_names[i]
  ggsave(name,
         plot = plots[[idx]],
         path = out_dir,
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
         path = out_dir,
         width = 6, height = 2.5)
  
}

print(paste("IMAGES saved to", out_dir, sep = " "))
