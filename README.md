# Predicting Car Prices Based on Certain Characteristics

Authors: Henry Zhang, Moira Renata, Ning Wang, Paige Wills, Xinrui Wang

## About

# TODO

## Report

The analysis report can be found [here](dsci310_milestone1.rmd).

## Usage

We use a Docker container image to make the computational environment for this project reproducible.

First, clone this repo in your terminal, navigate to the root of this project. Make sure your working directory contains [this Dockerfile](Dockerfile).

Then, build this image by 
```
docker build -t your-image-name . -f Dockerfile
```
After installing the packages in Dockerfile. You can run this on localhost:8787 by

```
docker run -p 8787:8787 -e PASSWORD=12345 -v "your\path\to\the\project:/project" your-image-name
```
OR
```
docker run -p 8787:8787 -e PASSWORD=12345 -v $(pwd):/project your-image-name
```

Open localhost:8787 on your browser. You can see the project on /project.

## Dependencies:

R version 4.1.3 and R packages listed in [Dockerfile](Dockerfile).

## License Information

This project is offered under 
the [Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/).
The software provided in this project is offered under the [MIT open source license](https://opensource.org/licenses/MIT). See [the license file](LICENSE.md) for more information. 
