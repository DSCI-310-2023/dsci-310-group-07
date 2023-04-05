library(here)

source(here("R/get_model.R"))
x_train_mat <- readRDS(here("analysis/vars/x_train_mat.rds"))
y_train_mat <- readRDS(here("analysis/vars/y_train_mat.rds"))

out_dir <- here("analysis/figs")
if (!dir.exists(out_dir)) {
  dir.create(out_dir)
}
# save plots from fitting models
get_model_plot(x_train_mat,y_train_mat,model="lasso",ask="plot")
get_model_plot(x_train_mat,y_train_mat,model="ridge",ask="plot")
print(paste("model plots saved to ", out_dir))