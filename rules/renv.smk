# Rules: renv
#
# All Rules related to the R package `renv`
#
# contributors: @lachlandeer, @julianlanger, @bergmul

# --- renv rules --- #

## renv_install: installs renv onto machine
rule renv_install:
    shell:
        "{runR} src/lib/install_renv.R"

## renv_consent: permission for renv to write files to system 
rule renv_consent:
    shell:
        "R -e 'renv::consent(provided = TRUE)'"

## renv_install: initialize a renv environment for this project
rule renv_init:
    shell:
        "R -e 'renv::init()'"

## renv_snap   : Look for new R packages in files & archives them
rule renv_snap:
    shell:
        "R -e 'renv::snapshot()'"

## renv_restore: Installs archived packages onto a new machine
rule renv_restore:
    shell:
        "R -e 'renv::restore()'"
