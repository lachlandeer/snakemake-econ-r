#' tab01_textbook_solow.R
#'
#' contributors: @lachlandeer, @julianlanger
#'
#' Table for Textbook Solow Model, Table 1 of MRW
#'

# Libraries
library(optparse)
library(rlist)
library(magrittr)
library(purrr)
library(stargazer)

# CLI parsing
option_list = list(
   make_option(c("-fp", "--filepath"),
               type = "character",
               default = NULL,
               help = "A directory path where models are saved",
               metavar = "character"),
   make_option(c("-m", "--models"),
               type = "character",
               default = NULL,
               help = "A regex of the models to load",
               metavar = "character"),
	make_option(c("-o", "--out"),
                type = "character",
                default = "out.tex",
                help = "output file name [default = %default]",
                metavar = "character")
);

opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

if (is.null(opt$filepath)){
 print_help(opt_parser)
 stop("Input filepath must be provided", call. = FALSE)
}
if (is.null(opt$models)){
 print_help(opt_parser)
 stop("A regex of model names must be provided", call. = FALSE)
}

# Load Files
dir_path  <- opt$filepath
f_names   <- opt$models
models    <- paste0(dir_path, f_names)
file_list <- Sys.glob(models)

# model names are from the files themselves
model_names <- basename(tools::file_path_sans_ext(file_list))

# Load into a list
data <- file_list %>%
            map(list.load) %>%
            setNames(model_names)

# Create Table
stargazer(data$model_solow_ols_subset_nonoil,
          data$model_solow_ols_subset_intermediate,
          data$model_solow_ols_subset_oecd,
          data$model_solow_restr_ols_subset_nonoil,
          data$model_solow_restr_ols_subset_intermediate,
          data$model_solow_restr_ols_subset_oecd,
          initial.zero = TRUE,
          align = FALSE,
          style = "qje",
          title = "Estimation of the Textbook Solow Model",
          dep.var.labels = "log(GDP per capita in 1965)",
          column.labels = c("Non-Oil", "Intermediate", "OECD",
                            "Non-Oil", "Intermediate", "OECD"),
          covariate.labels = c("log(I / GDP)",
                               "log(n + g + $\\delta$)",
                               "log(I / GDP) - log(n + g + $\\delta$)"
                               ),
          add.lines = list(
              c("Restricted Model", "No", "No", "No", "Yes", "Yes", "Yes")
          ),
          omit.stat = c("rsq", "ser", "F"),
          df = FALSE,
          digits = 2,
          font.size = "scriptsize",
          table.layout ="-dc#-t-a-s=n",
          no.space = TRUE,
          type = "latex",
          out = opt$out
          )
