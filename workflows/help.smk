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

## help_tables    : prints help comments for Snakefile in tables directory
rule help_tables:
    input: config["src_tables"] + "Snakefile"
    shell:
        "sed -n 's/^##//p' {input}"
