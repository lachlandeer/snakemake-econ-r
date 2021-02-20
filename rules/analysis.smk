# Rules: analysis
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

# --- Build Rules --- #
## estimate_models  : Helper rule that runs all regression models by expanding wildcards
rule estimate_models:
    input:
        expand(config["out_analysis"] +
                            "{iModel}.{iSubset}.rds",
                            iModel = MODELS,
                            iSubset = DATA_SUBSET)

## model        : Estimate an regression model on MRW data      
rule model:
    input:
        script = config["src_analysis"] + "estimate_ols_model.R",
        data   = config["out_data"] + "mrw_complete.csv",
        model  = config["src_model_specs"] + "{iModel}.json",
        subset = config["src_data_specs"] + "{iSubset}.json"
    output:
        model_est = config["out_analysis"] + "{iModel}.{iSubset}.rds",
    log:
        config["log"] + "analysis/{iModel}.{iSubset}.txt"
    shell:
        "{runR} {input.script} --data {input.data} --model {input.model} \
            --subset {input.subset} --out {output.model_est} \
            > {log} {logAll}"
