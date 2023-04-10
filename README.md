# Predicting Car Prices Based on Certain Characteristics

Authors: Haobo(Harbor) Zhang, Jiaying Liao, Ning Wang, Xiwen Wei

## About

In this project, we attempty to build a regression model to predict the car price given several charateristics of the car. The model will be selected using Lasso and Ridge regularizations. We also used 10-fold cross-validation to evaluate the performance of candidate models. The final model was selected by Lasso regularization and it includes idth, curb-weight, and horsepower as its variables. 

The data we used was from the The Automobile Data Set that was created by Jeffrey C. Schlimmer in 1985. The data were collected from <https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data>.

## Report

The analysis report can be found [here](analysis/report.rmd). 

In [pdf](analysis/report.pdf) and in [html](analysis/report.html).

## Usage

We use a Docker container image to make the computational environment for this project reproducible.

First, clone this repo in your terminal by `git clone https://github.com/DSCI-310/dsci-310-group-07.git`.

Navigate to the root of this project by `cd dsci-310-group-07`.

### Docker

Make sure your working directory contains [this Dockerfile](Dockerfile).

Then you can obtain the docker image in two different ways:

 * Pull from dockerhub (recommended, faster):
    * Go to [this webpage](https://hub.docker.com/r/wxw1026/dsci-310-group-07/tags).
    * Copy the command on the bottom right, which is 
    ```
    docker pull wxw1026/dsci-310-group-07:latest
    ```
    * Paste the command on your terminal and wait for pulling.
    * When the pulling is done, type 
    ```
    docker images wxw1026/dsci-310-group-07
    ``` 
    in your terminal and you will be able to see the image pulled.
  
 * Build it locally:
    * Type 
    ```
    docker build -t dsci-310-group-07 . -f Dockerfile
    ```
     in your terminal.
    * Wait for installation. It may take minutes.

After obtaining the docker image, you can run this on localhost:8787 by
```
docker run -it --rm -p 8787:8787 -e PASSWORD=12345 -v /$(pwd):/home/rstudio/project dsci-310-group-07
```

Open `localhost:8787/` on your browser. You will see a login page. The username is `rstudio` and the password is `12345`.

After signing in, you can see the project on `/home/rstudio/project`.

On the top right panel, open the terminal in rstudio container.


### Make


1. In your terimal, run the command `make report`. It will clean all the previous output (including dataset in .csv and plots in .png) and generate all the new output in need.

2. You can also run `make clean` to reset your work. 

3. Now `cd analysis/` and then `open report.pdf` or `open report.html` to read the report.


## Dependencies

R version 4.1.3 and R packages as follows:
 * remotes:2.4.2
 * tinytex:0.44
 * devtools:2.4.3
 * carpriceprediction:1.0.0
 * glmnet:4.1-4
 * tidyverse:1.3.1
 * testthat:3.1.3
 * here:1.0.1
 * knitr:1.38
 * ggcheck:0.0.4
 * rmarkdown:2.13
 * bookdown:0.26
 * cowplot:1.1.1
 * docopt:0.7.1
 

## License Information

This project is offered under 
the [Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/).
The software provided in this project is offered under the [MIT open source license](https://opensource.org/licenses/MIT). See [the license file](LICENSE.md) for more information. 
