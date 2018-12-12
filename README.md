# Reproducible Research Workflows with Snakemake and R

* Contributors:
    - Lachlan Deer (@lachlandeer) [cre, aut]
    - Julian Langer (@julianlanger)[cre,aut]

## What this Repo Does

We provide a template for a reproducible research project using `Snakemake` and the `R` programming language.
We use `Snakemake` to construct a set of *rules* that form a DAG that implements the entire research pipeline, starting with some data cleaning and finishing with compiling a pdf article and slides.
The `R` language is used to perform all steps of our analysis and to compile our pdf documents (the latter via `knitr` and `bookdown` packages).

Our example project involves replicating the main tables and figures of Mankiw, Romer and Weil's classic 1992 QJE article "[A Contribution to the Empirics of Economic Growth.](https://eml.berkeley.edu/~dromer/papers/MRW_QJE1992.pdf)"
We hope by using an example that is simple in its methods readers focus on how we have chosen to assemble both pur R codes and the Snakemake rules that build our project, rather than getting lost on econometric methodologies.

## How to Run the Example.


### Step 1: Installing Necessary Software
You need to have the following software and packages installed:

1. `R`
2. Python
3. Snakemake

Check out the installation instructions to below to get these three softwares installed on your machine.

Please lodge an issue if you find the instructions unclear.

## Step 2: Install the Required `R` libraries.

We utilize many additional R packages inside the scripts that build our project.
To ensure that our project runs on every machine without issues relating to R packages not being installed we utilize `packrat` to control the list of packages needed to run this example, and to monitor the version of the package we use.

Once you have completed the installation instructions above, we have provided a simple command to install packrat.
Open a terminal and navigate to this directory.
Then in the terminal enter the following command to install packrat:

```
snakemake packrat_install
```

Once this is complete you can use packrat to create a separate R environment that contains the packages we use in our example by entering the following command into the terminal:

```
snakemake packrat_restore
```

This will install all the packages we need. It may take a while.

## Step 3: Running the Example

Once steps 1 and 2 complete, we can run our project.
The result will be 2 pdfs: (1) mrw_replication.pdf - a pdf with some figures and tables of results included; and
(2) mrw_replication slides - some slides that also contain some figures and pdfs that were build using this project.

To run the project, enter the following into the terminal:

```
snakemake all
```

This will run through all the R scripts in order to complete the build of the project.


## Installation instructions

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

## Archiving `R` packages in a new project

* If you are starting a new project, which is likely if you are using
   this template, you need to initialize a new packrat instance to
   track your `R` packages and store them.
   Enter the following command into the same terminal as above
   and press `Return`.
   ```
   snakemake packrat_init
   ```


## Suggested Citation:

Deer, Lachlan and Julian Langer. 2018. Reproducible Economics Research Workflows with Snakemake.
