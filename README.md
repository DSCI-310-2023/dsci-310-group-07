# Predicting Car Prices Based on Certain Characteristics

Authors: Haobo(Harbor) Zhang, Jiaying Liao, Ning Wang, Xiwen Wei

## About

In this project, we attempty to build a regression model to predict the car price given several charateristics of the car. The model will be selected using Lasso and Ridge regularizations. We also used 10-fold cross-validation to evaluate the performance of candidate models. The final model was selected by Lasso regularization and it includes idth, curb-weight, and horsepower as its variables. And the root mean squared prediction error of this model is $65.43.

The data we used was from the The Automobile Data Set that was created by Jeffrey C. Schlimmer in 1985. The data were collected from <https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data>.

## Report

The analysis report can be found [here (Rmarkdown)](analysis/dsci310_milestone1.rmd) and [here (ipynb, to see the tables and graphs)](analysis/dsci310_milestone1.ipynb).

## Usage

We use a Docker container image to make the computational environment for this project reproducible.

First, clone this repo in your terminal, navigate to the root of this project. Make sure your working directory contains [this Dockerfile](Dockerfile).

Then, build this image by 
```
docker build -t dsci310-project . -f Dockerfile
```
After installing the packages in Dockerfile. You can run this on localhost:8787 by

```
docker run --rm -p 8787:8787 -e PASSWORD=12345 -v "your\path\to\the\project:/project" dsci310-project
```
OR
```
docker run --rm -p 8787:8787 -e PASSWORD=12345 -v $(pwd):/project dsci310-project
```

Open localhost:8787 on your browser. You can see the project on /project.

## Dependencies

R version 4.1.3 and R packages listed in [Dockerfile](Dockerfile).

## License Information

This project is offered under 
the [Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/).
The software provided in this project is offered under the [MIT open source license](https://opensource.org/licenses/MIT). See [the license file](LICENSE.md) for more information. 

## TODO

Add one more reference