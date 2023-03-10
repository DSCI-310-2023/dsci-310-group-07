#author: Jiaying Liao
#date: 2023-03-10

source(here::here("R/generate_tiny_dat.R"))

small_dat <- data.frame("col1" =  c(1,2,3),
                        "col2" = c("a","b",NA))
large_dat <- data.frame("col1" = 1:25,
                        "col2" = c(rep("zzz",24),NA))
small_dat_result <- data.frame("col1" =  c(1,2),
                               "col2" = c("a","b"))
large_dat_result <- data.frame("col1" = 1:24,
                               "col2" = rep("zzz",24))

testthat::expect_equivalent(generate_tiny_dat(small_dat),small_dat_result)
testthat::expect_equivalent(generate_tiny_dat(large_dat),large_dat_result)
