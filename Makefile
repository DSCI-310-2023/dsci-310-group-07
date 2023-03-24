# author: Ning Wang
# date: 2023-03-23

# download the data
data/automobile.csv: R/01-write_data.R
    Rscript R/01-write_data.R --input_dir="https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data" --out_dir="data"

# store all the plots
analysis/figs/length.png analysis/figs/width.png analysis/figs/curb_weight.png analysis/figs/eg_size.png analysis/figs/horse_pw.png analysis/figs/hw_mpg.png analysis/figs/cld.png analysis/figs/make.png: 04-eda_plots.R
	Rscript R/04-eda_plots.R 


.PHONY: report
report:
    Rscript -e "rmarkdown::render('analysis/report.rmd', output_dir='analysis')"
	
.PHONY: clean
clean:
	rm -f data/automobile.csv
	rm -f analysis/figs/length.png
	rm -f analysis/figs/width.png
	rm -f analysis/figs/curb_weight.png
	rm -f analysis/figs/eg_size.png
	rm -f analysis/figs/horse_pw.png
	rm -f analysis/figs/hw_mpg.png
	rm -f analysis/figs/report.html
	rm -f analysis/figs/cld.png
	rm -f analysis/figs/make.png
