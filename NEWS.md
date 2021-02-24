# snakemake-econ-r

## Version 0.5.1 (2021/02/24)

* Updates the Rscripts to build slides and pdfs to work in a way consistent with all other Rscripts in this project
  * Use `optparse` with meaningful defaults for CLI
  * Add barebones comments to scripts `build_article.R` and `build_slides.R` to try and explain what scripts are doing

## Version 0.5.0 (2021/02/20)

* Use `modelsummary` for regression tables rather than `stargazer`
* Table specifications are in form of JSON dictionaries rather than separate R scripts, to mirror other specs folders
* Better subfigure creation in main paper
* Move towards latex specification for table and figure objects, gives better control for how we want things

## Version 0.4.0 (2021/01/27)

* Compatible with R version 4.0.x via via [PR #7](https://github.com/lachlandeer/snakemake-econ-r/pull/7)
* Update Snakemake to version 5.32.0

## Version 0.3.0 (2020/10/2)

* Updated the version of Snakemake the example is compatible with (now Snakemake 5.26.1)
* One rule to build all tables via [PR #5](https://github.com/lachlandeer/snakemake-econ-r/pull/5) by [bergmul](https://github.com/bergmul) 


## Version 0.2.0 (2020/06/11)

* Added Travis CI build to check project builds from start to finish
* Migrate from Snakemake's subworkflow scheme to `include` to simplify setup with multiple files that contain rules
  * All rule files are now located in the `rules/` subdirectory 

## Version 0.1.1 (2020/06/09)

* Updated the version of Snakemake the example is compatible with (now Snakemake 5.18.0)

## Version 0.1.0 (2020/06/09)

* First complete version of workflow building with Snakemake utilizing subworkflows 