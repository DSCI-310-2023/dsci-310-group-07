saveVar <- function(var, name, out_dir) {
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }
  saveRDS(var, file = paste0(out_dir, "/", name))
  print(paste(name, "saved to", out_dir))
}

