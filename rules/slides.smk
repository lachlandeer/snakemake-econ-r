# Rules: slides
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

# --- Build Rules --- #
## slides2root:    move slides to root directory
rule slides2root:
    input:
        pdf  = config["out_slides"] + "slides.pdf"
    output:
        pdf  = PROJ_NAME + "_slides.pdf",
    shell:
        "cp {input.pdf} {output.pdf}"

## build_beamer: knit beamer slides
rule build_slides:
    input:
        runner    = config["src_lib"] + "build_slides.R",
        rmd_file  = config["src_slides"] + "slides.Rmd",
        tables    = config["out_tables"] +
                        "table_06.tex",
        figures   = expand(config["out_figures"] +
                            "{iPlot}.pdf",
                            iPlot = PLOTS),
        preamble  = config["src_slides"] + "preamble.tex"
    output:
        pdf = config["out_slides"] + "slides.pdf"
    log:
        config["log"]+ "slides/slides.Rout"
    shell:
        "{runR} {input.runner} \
            > {log} {logAll}"
