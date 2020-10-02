# Rules: clean
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

## clean_output   : delete all built files in project's output and ROOT directory
rule clean_output:
    shell:
        "rm -rf out/ *.pdf *.html"

## clean_logs     : delete all log files for this project
rule clean_log:
    shell:
        "rm -rf log/"