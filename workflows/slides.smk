# subworkflow: slides
#
# Contributors: @lachlandeer, @julianlanger

# --- Build Rules --- #
## slides2root:    move slides to root directory
rule slides2root:
    input:
        pdf  = config["out_slides"] + PROJ_NAME + "_slides.pdf"
    output:
        pdf  = PROJ_NAME + "_slides.pdf",
    shell:
        "cp {input.pdf} {output.pdf}"

## build_beamer: knit beamer slides
rule build_beamer:
    input:
        runner    = config["src_lib"] + "knit_beamer.R",
        rmd_file  = config["src_slides"] + "slides.Rmd",
        tables    = config["out_tables"] +
                        "tab03_ucc_solow.tex",
        figures   = config["out_figures"] +
                            "unconditional_convergence.pdf",
    output:
        pdf = config["out_slides"] + PROJ_NAME + "_slides.pdf"
    log:
        config["log"]+ "slides/slides.Rout"
    shell:
        "{runR} {input.runner} {input.rmd_file} {output.pdf} \
            > {log} {logAll}"
