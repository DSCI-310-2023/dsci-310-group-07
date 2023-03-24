# author: Ning Wang
# date: 2023-03-23

# download the data
data/automobile.csv: R/01-write_data.R
    Rscript R/01-write_data.R --input_dir="https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data" --out_dir="data"

# store all the plots
analysis/figs/length.png analysis/figs/width.png analysis/figs/curb_weight.png analysis/figs/eg_size.png analysis/figs/horse_pw.png analysis/figs/hw_mpg.png: 04-eda_plots.R
	Rscript R/04-eda_plots.R 


.PHONY: report
report:
    Rscript -e "rmarkdown::render('analysis/report.rmd', output_dir='analysis')"
	
.PHONY: clean
clean:
	rm -rf data/automobile.csv
	rm -rf analysis/figs/length.png
	rm -rf analysis/figs/width.png
	rm -rf analysis/curb_weight.png
	rm -rf analysis/eg_size.png
	rm -rf analysis/horse_pw.png
	rm -rf analysis/hw_mpg.png
	rm -rf analysis/report.html
