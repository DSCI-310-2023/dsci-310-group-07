# author: Ning Wang
# date: 2023-03-23

# runs all (1) (2) (3) (4) with one command, but not the report
all: data/automobile.csv data/levels.csv analysis/figs/length.png analysis/figs/width.png analysis/figs/curb_weight.png analysis/figs/eg_size.png analysis/figs/horse_pw.png analysis/figs/hw_mpg.png analysis/figs/cld.png analysis/figs/make.png data/kept.csv

# (1) download the data
data/automobile.csv: R/01-write_data.R
	Rscript R/01-write_data.R --input_dir="https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data"  --out_dir="data"

# (2) generates the levels.csv for EDA
data/levels.csv: R/02-read_data.R R/03-eda_tables.R data/automobile.csv
	Rscript R/03-eda_tables.R --out_dir="data"

# (3) stores all the plots for EDA
analysis/figs/length.png analysis/figs/width.png analysis/figs/curb_weight.png analysis/figs/eg_size.png analysis/figs/horse_pw.png analysis/figs/hw_mpg.png analysis/figs/cld.png analysis/figs/make.png:
	Rscript R/04-eda_plots.R 

# (4) generates the kept.csv
data/kept.csv: R/05-train_models.R
	Rscript R/05-train_models.R --out_dir="data"

# run docker container
.PHONY: container
container:
	docker run -it --rm -p 8787:8787 -e PASSWORD="a" -v /"$$(pwd)":/home/rstudio dsci-310-group-07

# generate the report
.PHONY: report
report:
	make clean 
	make all
	Rscript -e "rmarkdown::render('analysis/report.rmd', output_dir='analysis')"
	
# clean all output
.PHONY: clean
clean:
	rm -f data/kept.csv
	rm -f data/levels.csv
	rm -f data/automobile.csv
	rm -rf analysis/figs/
	rm -rf analysis/report.html