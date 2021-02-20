# Rules: tables
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

# --- Build Rules --- #

# make_tables: build all tables
rule make_tables:
    input:
        expand(config["out_tables"] + "{iTable}.tex",
                iTable = TABLES)

# table: build one table
rule tables:
    input:
        script = config["src_tables"] + "regression_table.R",
        spec   = config["src_table_specs"] + "{iTable}.json",
        models = expand(config["out_analysis"] +
                        "{iModel}.{iSubset}.rds",
                        iModel = MODELS,
                        iSubset = DATA_SUBSET),
    output:
        table = config["out_tables"] + "{iTable}.tex"
    log:
        config["log"] + "tables/{iTable}.txt"
    shell:
        "{runR} {input.script} \
            --spec {input.spec} \
            --out {output.table} \
            > {log} {logAll}"        