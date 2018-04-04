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
