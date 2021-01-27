# snakemake-econ-r

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