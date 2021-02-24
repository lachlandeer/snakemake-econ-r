# Rules: paper
#
# Compile paper as pdf using bookdown and rticles
#
# rticle-style: asa (see 'src/paper/_output.yml' for where we set the style)
# If you change the template, will need to change structure of yaml in 
# `src/paper/index.Rmd` accordingly
#
# contributors: @lachlandeer, @julianlanger, @bergmul

# --- Dictionaries --- #
RMD_FILES  = glob.glob(config["src_paper"] + "*.Rmd")
YAML_FILES = glob.glob(config["src_paper"] + "*.yml")
BIB_FILES  = glob.glob(config["src_paper"] + "*.bib")
TEX_FILES  = glob.glob(config["src_paper"] + "*.tex")

# --- Build Rules --- #
## paper2root:   copy paper to root directory
rule paper2root:
    input:
        pdf  = config["out_paper"] + "article.pdf",
    output:
        pdf  = PROJ_NAME + ".pdf",
    shell:
        "cp {input.pdf} {output.pdf}"

## build_paper: builds pdf using bookdown
rule build_paper:
    input:
        text_files = RMD_FILES,
        yaml_files = YAML_FILES,
        biblo      = BIB_FILES,
        tex_style  = TEX_FILES,
        tables     = expand(config["out_tables"] +
                            "{iTable}.tex",
                            iTable = TABLES),
        figures = expand(config["out_figures"] +
                            "{iPlot}.pdf",
                            iPlot = PLOTS),
        runner     = config["src_lib"] + "build_article.R"
    output:
        config["out_paper"] + "article.pdf"
    log:
        config["log"] + "paper/build_article.Rout"
    shell:
        "{runR} {input.runner} > {log} {logAll}"
