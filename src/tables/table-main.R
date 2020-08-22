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
library(stargazer)

# CLI parsing
option_list = list(
   make_option(c("-f", "--filepath"),
               type = "character",
               default = NULL,
               help = "A directory path where models are saved",
               metavar = "character"),
    make_option(c("-s", "--spec"),
               type = "character",
               default = NULL,
               help = "Input filename table spec",
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
if (is.null(opt$spec)){
 print_help(opt_parser)
 stop("Input spec must be provided", call. = FALSE)
}
if (is.null(opt$models)){
 print_help(opt_parser)
 stop("A regex of model names must be provided", call. = FALSE)
}

# Load Files
dir_path  <- opt$filepath
s_name    <- opt$spec
f_names   <- opt$models
models    <- paste0(dir_path, f_names)
file_list <- Sys.glob(models)

# model names are from the files themselves
model_names <- basename(tools::file_path_sans_ext(file_list))

# Load into a list
data <- file_list %>%
            map(list.load) %>%
            setNames(model_names)

# Create Table according to table spec
source(s_name)
