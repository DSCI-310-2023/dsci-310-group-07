FROM rocker/rstudio:4.1.3

# Install R packages
RUN Rscript -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('cowsay','0.8.0')"
