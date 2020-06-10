# subworkflow: help
#
# Contributors: @lachlandeer, @julianlanger

## help_analysis  : prints help comments for Snakefile in analysis directory
rule help_analysis:
    input: config["workflows"] + "analysis.smk"
    shell:
        "sed -n 's/^##//p' {input}"

## help_data_mgt  : prints help comments for Snakefile in data-management directory
rule help_data_mgt:
    input: config["workflows"] + "data_mgt.smk"
    shell:
        "sed -n 's/^##//p' {input}"

## help_figures   : prints help comments for Snakefile in figures directory
rule help_figures:
    input: config["workflows"] + "figures.smk"
    shell:
        "sed -n 's/^##//p' {input}"

## help_paper     : prints help comments for Snakefile in paper directory
rule help_paper:
    input: config["workflows"] + "paper.smk"
    shell:
        "sed -n 's/^##//p' {input}"

## help_slides    : prints help comments for Snakefile in slides directory
rule help_slides:
    input: config["workflows"] + "slides.smk"
    shell:
        "sed -n 's/^##//p' {input}"

## help_tables    : prints help comments for Snakefile in tables directory
rule help_tables:
    input: config["workflows"] + "tables.smk"
    shell:
        "sed -n 's/^##//p' {input}"
