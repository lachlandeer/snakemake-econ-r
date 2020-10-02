# Rules: figures
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

## make_figs: Helper rule to expand wildcard and generate all figures
rule make_figs:
    input:
        expand(config["out_figures"] + "{iFigure}.pdf",
                iFigure = PLOTS)

## figures: the recipe to make a figures using intermediate country data from MRW
rule figures:
    input:
        script = config["src_figures"] + "{iFigure}.R",
        data   = config["out_data"] + "mrw_complete.csv",
        subset = config["src_data_specs"] + "subset_intermediate.json"
    output:
        fig = config["out_figures"] + "{iFigure}.pdf",
    log:
        config["log"] + "figures/{iFigure}.txt"
    shell:
        "{runR} {input.script} \
            --data {input.data} \
            --subset {input.subset} \
            --out {output.fig} \
            > {log} {logAll}"
