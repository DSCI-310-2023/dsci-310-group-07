FROM rocker/rstudio:4.1.3

# Install R packages
RUN Rscript -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('cowsay','0.8.0')"
RUN Rscript -e "remotes::install_version('glmnet','4.1-4')"
RUN Rscript -e "remotes::install_version('MASS','7.3-57')"
