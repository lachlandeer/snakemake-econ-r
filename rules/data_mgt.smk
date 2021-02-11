# Rules: data-management
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

# --- Build Rules --- #
## gen_regression_vars: creates the set of variables needed to produce MRW results
rule gen_regression_vars:
    input:
        script = config["src_data_mgt"] + "gen_reg_vars.R",
        data   = config["out_data"] + "mrw_renamed.csv"
    output:
        data = config["out_data"] + "mrw_complete.csv",
    params:
        solow_const = 0.05
    log:
        config["log"] + "data_cleaning/gen_reg_vars.txt"
    shell:
        "{runR} {input.script} --data {input.data} --param {params.solow_const} \
            --out {output.data} \
            > {log} {logAll}"

## rename_vars     : gives meaningful names to variables 
rule rename_vars:
    input:
        script = config["src_data_mgt"] + "rename_variables.R",
        data   = config["src_data"] + "mrw.dta",
    output:
        data = config["out_data"] + "mrw_renamed.csv",
    log:
        config["log"] + "data_cleaning/rename_variables.txt"
    shell:
        "{runR} {input.script} --data {input.data} --out {output.data} \
            > {log} {logAll}"
