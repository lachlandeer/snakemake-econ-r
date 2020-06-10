# subworkflow: analysis
#
# Contributors: @lachlandeer, @julianlanger

# --- Build Rules --- #
## estimate_models  : Helper rule that runs all regression models by expanding wildcards
rule estimate_models:
    input:
        expand(config["out_analysis"] +
                            "ols_{iModel}_{iSubset}.rds",
                            iModel = MODELS,
                            iSubset = DATA_SUBSET)

## ols_model        : Estimate an OLS regression model on MRW data      
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
