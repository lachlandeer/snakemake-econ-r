# PROJECT NAME

* Contributors:
    - YOUR NAME (YOUR GH HANDLE) [cre, aut]

## Cool Documentation

**IN PROGRESS**

TO DO:

1. add an all rule to the ROOT Snakefile
2. Add Snakefile skeletons to each of the directories where work is likley to take place

## How to Run

1. Open a terminal and navigate to this directory
2. run `snakemake all`

## Install instructions

The goal is to make our entire workflow reproducible.
To do this we want
(i) the steps we need to take to process everything (our *workflow*)
    should be explicitly stated;
(ii) any packages we load in our `R` code to be stored so everyone who tries to
    run our code has the same versions installed

### Installing `R`

* Install the latest version of `R` by following the instructions
  [here](https://pp4rs.github.io/installation-guide/r/).
    * You can ignore the RStudio instructions for the purpose of this project.

### Documenting and Executing the Workflow
This project uses `Snakemake` to execute our research workflow.
You can install snakemake as follows:
* Install Snakemake from the command line (needs pip, and Python)
    ```
    pip install snakemake
    ```
    * If you haven't got Python installed click [here](https://pp4rs.github.io/installation-guide/python/) for instructions

### Archiving our `R` packages

To ensure that the same output is returned whenever our code is run we
want to ensure that the same `R` packages are used, and that the save *version* of the package is used. `Packrat` is a package manager that facilitates this task for us.

`packrat` is itself an `R` package. Once you have installed `R` and `Snakemake` we can install packrat as follows:

* Open a terminal and navigate to this folder.
* Install packrat by entering the following into the terminal, and pressing `Return`:
    ```
    snakemake packrat_install
    ```
    This opens an R session to install packrat for us.


## LICENSE

TBD

## Suggested Citation:

Deer, Lachlan. 2018. Reproducible Research Projects with R, Packrat and Snakemake.
