#'author: Jiaying Liao
#'date: 2023-03-22
#'
#'This R script will saves the plots for EDA analysis

library(tidyverse)
library(here)
library(cowplot)

source(here("R/02-read_data.R"))
source(here("R/03-eda_tables.R"))
source(here("R/plotAll.R"))


# obtain plots from `plotAll` function
plots <- plotAll(automobile, nms)

# This function will save the bar plot to figs
save_single_plot <- function(pl, name) {
  ggsave(name,
         plot = pl,
         path = here("analysis/figs"),
         width = 5, height = 3)
}

save_single_plot(plots[[1]],"make.png")
save_single_plot(plots[[8]],"cld.png")

# This function will combine an histogram and scatterplot, and save it in figs
save_combine_plot <- function(pl1,pl2,name) {
  ggsave(name,
         plot = plot_grid(pl1,pl2),
         path = here("analysis/figs"),
         width = 6, height = 2.5)
}

save_combine_plot(plots[[2]],plots[[3]],"length.png")
save_combine_plot(plots[[4]],plots[[5]],"width.png")
save_combine_plot(plots[[6]],plots[[7]],"curb_weight.png")
save_combine_plot(plots[[9]],plots[[10]],"eg_size.png")
save_combine_plot(plots[[11]],plots[[12]],"horse_pw.png")
save_combine_plot(plots[[13]],plots[[14]],"hw_mpg.png")


