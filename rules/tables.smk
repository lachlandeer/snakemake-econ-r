# Rules: tables
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

# --- Build Rules --- #

# one table to rule them all
rule make_tables:
    input:
        script = config["src_tables"] + "table-main.R",
# TODO: generalize to all files in folder
        spec   = config["src_table_specs"] + "{iTable}.R",
        models = expand(config["out_analysis"] +
                        "{iModel}_ols_{iSubset}.rds",
                        iModel = MODELS,
                        iSubset = DATA_SUBSET),
    params:
        filepath   = config["out_analysis"],
# TODO: fix model expression hack - for now always read all models
        model_expr = "*.rds"
    output:
        table = config["out_tables"] + "{iTable}.tex"
    log:
        config["log"] + "tables/{iTable}.txt"
    shell:
        "{runR} {input.script} \
            --filepath {params.filepath} \
            --spec {input.spec} \
            --models {params.model_expr} \
            --out {output.table} \
            > {log} {logAll}"        