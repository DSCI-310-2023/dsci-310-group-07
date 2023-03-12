# author: Ning Wang
# date: 2023-03-11

library(testthat)
library(here)

source(here("R/get_model.R"))
source(here("R/01-write_data.R"))
source(here("R/02-read_data.R"))
source(here("R/generate_tiny_dat.R"))


# expect_equal(nrow(get_tr_tst(automobile,"at")[[1]]),14)

df<-generate_tiny_dat(automobile)
df

expect_equal(nrow(get_tr_tst(df,"at")[[1]]),14)

expect_equal(nrow(get_tr_tst(df,"at")[[2]]),6)

