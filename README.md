# Predicting Car Prices Based on Certain Characteristics

Authors: Haobo(Harbor) Zhang, Jiaying Liao, Ning Wang, Xiwen Wei

## About

In this project, we attempty to build a regression model to predict the car price given several charateristics of the car. The model will be selected using Lasso and Ridge regularizations. We also used 10-fold cross-validation to evaluate the performance of candidate models. The final model was selected by Lasso regularization and it includes idth, curb-weight, and horsepower as its variables. And the root mean squared prediction error of this model is $65.43.

The data we used was from the The Automobile Data Set that was created by Jeffrey C. Schlimmer in 1985. The data were collected from <https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data>.

## Report

The analysis report can be found [here](analysis/report.rmd).

## Usage

#Method 1 -- Via Docker
We use a Docker container image to make the computational environment for this project reproducible.

First, clone this repo in your terminal by `git clone https://github.com/wxw1026/dsci-310-group-07.git`.

Navigate to the root of this project by `cd dsci-310-group-07`.

Make sure your working directory contains [this Dockerfile](Dockerfile).

Then you can obtain the docker image in two different ways:

 * Pull from dockerhub (recommended, faster):
    * Go to [this webpage](https://hub.docker.com/r/wxw1026/dsci-310-group-07/tags).
    * Copy the command on the bottom right, which is `docker pull wxw1026/dsci-310-group-07:latest`
    * Paste the command on your terminal and wait for pulling.
    * When the pulling is done, type `docker images wxw1026/dsci-310-group-07` in your terminal.
    * Copy the IMAGE ID, which should be in the third column.
    * Type ` docker tag <IMAGE ID> dsci310-project` in your terminal.
  
 * Build it locally:
    * Type `docker build -t dsci310-project . -f Dockerfile` in your terminal.
    * Wait for installation. It may take minutes.

After obtaining the docker image, you can run this on localhost:8787 by
```
docker run --rm -p 8787:8787 -e PASSWORD=12345 -v /$(pwd):/home/rstudio/project dsci310-project
```

Open `localhost:8787/` on your browser. You will see a login page. The username is `rstudio` and the password is `12345`

After signing in, you can see the project on `/home/rstudio/project`.

On the bottom right panel, click into `project`, you will be able to see a folder `analysis`. 

Go to `analysis`, you can click on `report.html`, and select `View in Web Browser` to see the knitted html report. 

You can also run the report with the following steps:
 * In `analysis`, click on `report.rmd`. 
 * Now `report.rmd` can be seen on the top left panel. 
 * Run each code chunck by clicking the green triangles. Make sure you run all the chuncks above the chunk you want to run, otherwise, there will be error.

#Method 2 -- Via Make

1. Clone the github repo using the same procedure as Method 1. 

2. `cd` to the root of the cloned repo on your computer(`dsci-310-group-07/`), then run:

```
make
```

3. Run the following command to reset your work: 
```
make clean
```

## Dependencies

R version 4.1.3 and R packages as follows:
 * remotes:2.4.2
 * glmnet:4.1-4
 * leaps:3.1
 * tidyverse:1.3.1
 * testthat:3.1.3
 * here:1.0.1
 * knitr:1.38
 * ggcheck:0.0.4
 * kableExtra:1.3.4
 * MASS:7.3-55
 * glmnet:4.1-4
 * rmarkdown:2.13
 * bookdown:0.26
 * cowplot:1.1.1
    

## License Information

This project is offered under 
the [Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/).
The software provided in this project is offered under the [MIT open source license](https://opensource.org/licenses/MIT). See [the license file](LICENSE.md) for more information. 
