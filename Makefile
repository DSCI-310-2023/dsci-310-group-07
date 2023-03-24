.PHONY: test
test:
	Rscript -e "source('tests/generate_tiny_dat_test.R')"
	Rscript -e "source('tests/showR2_test.R')"
	Rscript -e "source('tests/processdata-test.R')"
	Rscript -e "source('tests/plotAll-test.R')"
	Rscript -e "source('tests/get_model_test.R')"
	Rscript -e "source('tests/make_kable_test.R')"

.PHONY: report
report:
	Rscript -e "rmarkdown::render('analysis/report.rmd', output_dir='analysis')"
	
.PHONY: clean
clean:
	rm -f analysis/report.html report.html
