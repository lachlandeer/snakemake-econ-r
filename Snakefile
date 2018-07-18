# Main Workflow - YOUR PROJECT NAME HERE
# Contributors: YOUR GITHUB HANDLE

import glob, os

# --- Importing Configuration Files --- #

configfile: "config.yaml"

# --- Dictionaries --- #
# Identify subset conditions for data
DATA_SUBSET = [os.path.splitext(os.path.basename(iFile))[0]
                    for iFile in glob.glob(config["src_data_specs"] +
                                            "*.json")]

MODELS = [os.path.splitext(os.path.basename(iFile))[0]
                    for iFile in glob.glob(config["src_model_specs"] +
                                            "model_*.json")]

# --- Sub Workflows --- #
subworkflow data_mgt:
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

# --- Variable Declarations ---- #
runR = "Rscript --no-save --no-restore --verbose"
logAll = "2>&1"

# --- Main Build Rules --- #

rule all:
    input:
        model = analysis(expand(config["out_analysis"] +
                            "{iModel}_ols_{iSubset}.rds",
                            iModel = MODELS,
                            iSubset = DATA_SUBSET)),
        ucc_plt= figures(config["out"] +
                        "figures/unconditional_convergence.pdf")
        #data = data_mgt(config["out_data"] + "mrw_complete.csv")

# --- Packrat Rules --- #

## packrat_install: installs packrat onto machine
rule packrat_install:
    shell:
        "R -e 'install.packages(\"packrat\", repos=\"http://cran.us.r-project.org\")'"

## packrat_install: initialize a packrat environment for this project
rule packrat_init:
    shell:
        "R -e 'packrat::init()'"

## packrat_snap   : Look for new R packages in files & archives them
rule packrat_snap:
    shell:
        "R -e 'packrat::snapshot()'"

## packrat_restore: Installs archived packages onto a new machine
rule packrat_restore:
    shell:
        "R -e 'packrat::restore()'"

# --- Cleaning Rules --- #

## clean_all      : delete all output and log files for this project
rule clean_all:
    shell:
        "rm -rf out/ log/ *.pdf *.html"

## clean_output   : delete all built files in project's output and ROOT directory
rule clean_output:
    shell:
        "rm -rf out/ *.pdf *.html"

## clean_logs     : delete all log files for this project
rule clean_log:
    shell:
        "rm -rf log/"

# --- Help Rules --- #

## help_main      : prints help comments for Snakefile in ROOT directory
rule help_main:
    input: "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_analysis  : prints help comments for Snakefile in analysis directory
rule help_analysis:
    input: config["src_analysis"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_data_mgt  : prints help comments for Snakefile in data-management directory
rule help_data_mgt:
    input: config["src_data_mgt"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_figures   : prints help comments for Snakefile in figures directory
rule help_figures:
    input: config["src_figures"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_paper     : prints help comments for Snakefile in paper directory
rule help_paper:
    input: config["src_paper"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_slides    : prints help comments for Snakefile in slides directory
rule help_slides:
    input: config["src_slides"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"

## help_tables    : prints help comments for Snakefile in analysis directory
rule help_tables:
    input: config["src_tables"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"
