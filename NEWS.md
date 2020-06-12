# snakemake-econ-r

## Version 0.2.0 (2020/06/11)

* Added Travis CI build to check project builds from start to finish
* Migrate from Snakemake's subworkflow scheme to `include` to simplify setup with multiple files that contain rules
  * All rule files are now located in the `rules/` subdirectory 

## Version 0.1.1 (2020/06/09)

* Updated the version of Snakemake the example is compatabile with (now Snakemake 5.18.0)

## Version 0.1.0 (2020/06/09)

* First complete version of workflow building with Snakemake utilizing subworkflows