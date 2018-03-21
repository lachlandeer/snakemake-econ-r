# Main Workflow - YOUR PROJECT NAME HERE
# Contributors: YOUR GITHUB HANDLE

import glob, os

# --- Importing Configuration Files --- #

configfile: "config.yaml"

# --- Dictionaries --- #


# --- Sub Workflows --- #
subworkflow data_cleaning:
   workdir: "."
   snakefile: config["src_data_mgt"] + "Snakefile"

# subworkflow figures:
#    workdir: "."
#    snakefile: config["src_figures"] + "Snakefile"

# --- Main Build Rules --- #


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
