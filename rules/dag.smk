# Rules: dag
#
# Generate Graphs of DAG and related content
#
# Contributors: @lachlandeer, @julianlanger, @bergmul

## dag                : create the DAG as a pdf from the Snakefile
rule dag:
    input:
        "Snakefile"
    output:
        "dag.pdf"
    shell:
        "snakemake --dag | dot -Tpdf > {output}"

## filegraph          : create the file graph as pdf from the Snakefile 
##                     (i.e what files are used and produced per rule)
rule filegraph:
    input:
        "Snakefile"
    output:
        "filegraph.pdf"
    shell:
        "snakemake --filegraph | dot -Tpdf > {output}"

## rulegraph          : create the graph of how rules piece together 
rule rulegraph:
    input:
        "Snakefile"
    output:
        "rulegraph.pdf"
    shell:
        "snakemake --rulegraph | dot -Tpdf > {output}"

## rulegraph_to_png
rule rulegraph_to_png:
    input:
        "rulegraph.pdf"
    output:
        "assets/rulegraph.png"
    shell:
        "pdftoppm -png {input} > {output}"


# --- INSTALL GRAPHVIZ --- #

## install_graphviz   : install necessary packages to visualize Snakemake workflow 
rule graphviz:
    shell:
        "sudo apt-get install graphviz"

## install_graphviz_mac : install necessary packages to visualize Snakemake workflow on a mac 
rule graphviz_mac:
    shell:
        "brew install graphviz"

## install_poppler: install poppler-utils on ubuntu
rule install_poppler:
    shell:
        "sudo apt-get install -y poppler-utils"