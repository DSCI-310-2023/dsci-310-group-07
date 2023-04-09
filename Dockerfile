FROM rocker/rstudio:4.1.3

# update ubuntu repos and install tidyverse system dependencies
RUN apt update -y
RUN apt install -y libcurl4-openssl-dev libssl-dev libxml2-dev zlib1g-dev libxt6

# Install R packages
RUN Rscript -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('tinytex', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "tinytex::install_tinytex()"
RUN Rscript -e "remotes::install_version('devtools','2.4.3')"
RUN Rscript -e "devtools::install_github('DSCI-310/dsci-310-group-07-pkg')"
RUN Rscript -e "remotes::install_version('glmnet','4.1-4')"
RUN Rscript -e "remotes::install_version('tidyverse','1.3.1')"
RUN Rscript -e "remotes::install_version('testthat','3.1.3')"
RUN Rscript -e "remotes::install_version('here','1.0.1')"
RUN Rscript -e "remotes::install_version('knitr','1.38')"
RUN Rscript -e "remotes::install_github('rstudio/ggcheck')"  
RUN Rscript -e "remotes::install_version('rmarkdown','2.13')"
RUN Rscript -e "remotes::install_version('cowplot','1.1.1')"
RUN Rscript -e "remotes::install_version('bookdown','0.26')"
RUN Rscript -e "remotes::install_version('docopt','0.7.1')"


