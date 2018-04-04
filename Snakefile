# Main Workflow - YOUR PROJECT NAME HERE
# Contributors: YOUR GITHUB HANDLE

import glob, os

# --- Importing Configuration Files --- #

configfile: "config.yaml"

# --- Dictionaries --- #


# --- Sub Workflows --- #
subworkflow data_cleaning:
   workdir:   config["ROOT"]
   snakefile: config["src_data_mgt"] + "Snakefile"

subworkflow analysis:
   workdir:   config["ROOT"]
   snakefile: config["src_analysis"] + "Snakefile"

subworkflow tables:
   workdir:   config["ROOT"]
   snakefile: config["src_tables"] + "Snakefile"

subworkflow figures:
   workdir:   config["ROOT"]
   snakefile: config["src_figures"] + "Snakefile"

subworkflow paper:
   workdir: config["src_paper"]
   snakefile:  config["src_paper"] + "Snakefile"

subworkflow slides:
   workdir: config["src_slides"]
   snakefile: config["src_slides"] + "Snakefile"

# --- Main Build Rules --- #

# To be Done

# --- Packrat Rules --- #
rule packrat_install:
    shell:
        "R -e 'install.packages(\"packrat\", repos=\"http://cran.us.r-project.org\")'"

rule packrat_init:
    shell:
        "R -e 'packrat::init()'"

rule packrat_snap:
    shell:
        "R -e 'packrat::snapshot()'"

rule packrat_restore:
    shell:
        "R -e 'packrat::restore()'"

# --- Cleaning Rules --- #

rule clean_all:
    shell:
        "rm -rf out/ log/ *.pdf *.html"

rule clean_output:
    shell:
        "rm -rf out/ *.pdf *.html"

rule clean_log:
    shell:
        "rm -rf log/"

# --- Help Rules --- #

## help_main: prints help comments for Snakefile in ROOT directory
rule help_main:
    input: "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_analysis: prints help comments for Snakefile in analysis directory
rule help_analysis:
    input: config["src_analysis"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_data_mgt: prints help comments for Snakefile in data-management directory
rule help_data_mgt:
    input: config["src_data_mgt"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_figures: prints help comments for Snakefile in figures directory
rule help_figures:
    input: config["src_figures"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_paper: prints help comments for Snakefile in paper directory
rule help_paper:
    input: config["src_paper"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_slides: prints help comments for Snakefile in slides directory
rule help_slides:
    input: config["src_slides"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_tables: prints help comments for Snakefile in analysis directory
rule help_tables:
    input: config["src_tables"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"
