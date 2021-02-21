#' table-main.R
#'
#' contributors: @lachlandeer, @julianlanger, @bergmul
#'
#' Creates MRW tables according to specification
#'

# Libraries
library(optparse)
library(rlist)
library(magrittr)
library(purrr)
library(rjson)
library(modelsummary)
library(kableExtra)
library(here)
library(tibble)

# CLI parsing
option_list = list(
   make_option(c("-s", "--spec"),
               type = "character",
               default = NULL,
               help = "a json dictionary of table parameters",
               metavar = "character"),
	make_option(c("-o", "--out"),
               type = "character",
               default = "out.tex",
               help = "output file name [default = %default]",
               metavar = "character")
);

opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

if (is.null(opt$spec)){
   print_help(opt_parser)
   stop("Table specification must be provided (as a json)", call. = FALSE)
}

# Load Model
print("LoadingTable Specification Model")
tab_str <- fromJSON(file = opt$spec)

# parse JSON
model_path <- tab_str$MODEL_PATH
models     <- eval(parse(text = tab_str$MODELS))
col_names <-  eval(parse(text = tab_str$COL_NAMES))

# construct list of files we want to load
file_list <- here(tab_str$MODEL_PATH, models)
# get the file names
model_names <- basename(tools::file_path_sans_ext(file_list))

# load the regressions
reg <- file_list %>%
   map(list.load) %>%
   setNames(model_names)

# setting up column names of table
names(reg) <- col_names

# Information about whether to add a model restriction row to regression table
if (as.logical(tab_str$RESTRICTED_MODEL) == TRUE){
  message("table has restricted models")
  custom_row <- eval(parse(text = tab_str$RESTRICTION_LOG))
  attr(custom_row, 'position') <- as.numeric(tab_str$RESTRICTION_POSITION)
} else{
  message("table does not have restricted models")
  custom_row <- NULL
}

# Formatters for Goodess of fit stats
f_int <- function(x) format(round(x, 2), big.mark=",", nsmall = 0) # integers
f_dec <- function(x) format(round(x, 2), big.mark=",", nsmall = 2) # floats

# What Goodness of Fit Stats we include (constant across tables)
gm <- list(
  list("raw" = "nobs", "clean" = "N", "fmt" = f_int),
  list("raw" = "r.squared", "clean" = "$R^2$", "fmt" = f_dec))

# Regression table
tab <- modelsummary(reg,
                    fmt = "%.2f",
                    # coef map is constant across regression tables
                    coef_map = c(    'ln_gdp_60' = 'log(GDP per capita 1960)',
                                     'ln_inv_gdp' = 'log(I / GDP)',
                                     'ln_ndg' = 'log(n + g + $\\delta$)',
                                     'ln_school' = 'log(school)',
                                     'I(ln_inv_gdp - ln_ndg)'=  'log(I / GDP) - log(n + g + $\\delta$)',
                                     'I(ln_school - ln_ndg)' = 'log(school) - log(n + g + $\\delta$)',
                                     '(Intercept)' = 'Constant'
                                  ),
                    statistic = "std.error",
                    stars = FALSE,
                    stars_note = FALSE,
                    gof_omit = 'DF|Deviance|Adj|AIC|BIC|Log.|F',
                    gof_map = gm,
                    add_rows = custom_row,
                    output = 'latex_tabular',
                    escape = FALSE # render latex as latex- needs FALSE
      ) %>%
    add_header_above(eval(parse(text = tab_str$ADDITIONAL_HEADER))) %>%
    add_header_above(eval(parse(text = tab_str$DEP_VAR))) 

# add additional line structure around restriction rows if they are added
if (as.logical(tab_str$RESTRICTED_MODEL) == TRUE){
  message("adding structure around additional rows")
  tab <- tab %>%
        row_spec(as.numeric(tab_str$RESTRICTION_POSITION), 
                 extra_latex_after = "\\midrule")
}

# save the output
tab

tab %>%
  save_kable(file = opt$out, self_contained = FALSE)
