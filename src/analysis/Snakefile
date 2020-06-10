# subworkflow: analysis
#
# Contributors: @lachlandeer, @julianlanger

# --- Build Rules --- #
rule estimate_models:
    input:
        expand(config["out_analysis"] +
                            "ols_{iModel}_{iSubset}.rds",
                            iModel = MODELS,
                            iSubset = DATA_SUBSET)

rule ols_model:
    input:
        script = config["src_analysis"] + "estimate_ols_model.R",
        data   = config["out_data"] + "mrw_complete.csv",
        model  = config["src_model_specs"] + "{iModel}.json",
        subset = config["src_data_specs"] + "{iSubset}.json"
    output:
        model_est = config["out_analysis"] + "{iModel}_ols_{iSubset}.rds",
    log:
        config["log"] + "analysis/{iModel}_ols_{iSubset}.txt"
    shell:
        "{runR} {input.script} --data {input.data} --model {input.model} \
            --subset {input.subset} --out {output.model_est} \
            > {log} {logAll}"
