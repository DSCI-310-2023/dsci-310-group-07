.PHONY: report
report:
	Rscript -e "rmarkdown::render('analysis/report.rmd', output_dir='analysis')"
	
.PHONY: clean
clean:
	rm -f analysis/report.html report.html