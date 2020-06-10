# Main Workflow - MRW Replication
# Contributors: @lachlandeer, @julianlanger

import glob

# --- Importing Configuration Files --- #
configfile: "paths.yaml"

# --- PROJECT NAME --- #
PROJ_NAME = "mrw_replication"

# --- Dictionaries --- #
# Identify subset conditions for data
DATA_SUBSET = glob_wildcards(config["src_data_specs"] + "{fname}.json").fname
# Models we want to estimate
MODELS = glob_wildcards(config["src_model_specs"] + "{fname}.json").fname
# plots we want to build
PLOTS = glob_wildcards(config["src_figures"] + "{fname}.R").fname
# tables to generate
TABLES = glob_wildcards(config["src_tables"] + "{fname}.R").fname

# --- Sub Workflows --- #
# Include all other Snakefiles that contain rules that are part of the project
include: config["workflows"] + "renv.smk"
include: config["workflows"] + "clean.smk"
include: config["workflows"] + "help.smk"

include: config["workflows"] + "data_mgt.smk"
include: config["workflows"] + "analysis.smk"
include: config["workflows"] + "figures.smk"
include: config["workflows"] + "tables.smk"
include: config["workflows"] + "paper.smk"
include: config["workflows"] + "slides.smk"

# --- Variable Declarations ---- #
runR = "Rscript --no-save --no-restore --verbose"
logAll = "2>&1"

# --- Main Build Rule --- #
## all            : build paper and slides that are the core of the project
rule all:
    input:
        paper_pdf     = PROJ_NAME + ".pdf",
        beamer_slides = PROJ_NAME + "_slides.pdf"

# --- Cleaning Rules --- #
## clean_all      : delete all output and log files for this project
rule clean_all:
    shell:
        "rm -rf out/ log/ *.pdf *.html"

# --- Help Rules --- #
## help_main      : prints help comments for Snakefile in ROOT directory. 
##                  Help for rules in other parts of the workflows (i.e. in workflow/)
##                  can be called by `snakemake help_<workflowname>`
rule help_main:
    input: "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"
