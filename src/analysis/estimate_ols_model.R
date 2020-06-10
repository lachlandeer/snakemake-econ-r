#' estimate_ols_model.R
#'
#' contributors: @lachlandeer, @julianlanger
#'
#' Run and OLS regression on a (subset of) data
#'

# Libraries
library(optparse)
library(rjson)
library(readr)
library(rlist)

# CLI parsing
option_list = list(
   make_option(c("-d", "--data"),
               type = "character",
               default = NULL,
               help = "a csv file name",
               metavar = "character"),
   make_option(c("-m", "--model"),
               type = "character",
               default = NULL,
               help = "a file name containing a regression model",
               metavar = "character"),
   make_option(c("-s", "--subset"),
               type = "character",
               default = NULL,
               help = "A condition to select a subset of data",
               metavar = "character"),
	make_option(c("-o", "--out"),
                type = "character",
                default = "out.rds",
                help = "output file name [default = %default]",
                metavar = "character")
);

opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

if (is.null(opt$data)){
 print_help(opt_parser)
 stop("Input data must be provided", call. = FALSE)
}
if (is.null(opt$model)){
 print_help(opt_parser)
 stop("Regression Model must be provided", call. = FALSE)
}
if (is.null(opt$subset)){
 print_help(opt_parser)
 stop("A subsetting condition", call. = FALSE)
}

# Load data
print("Loading data")
df <- read_csv(opt$data)

# Load Model
print("Loading Regression Model")
model_structure <- fromJSON(file = opt$model)

# Load Subset Condition
print("Loading Subsetting Condition")
data_filter <- fromJSON(file = opt$subset)

# Filter data
reg_data <- subset(df, eval(parse(text = data_filter$KEEP_CONDITION)))

# Construct Formula
dep_var <- model_structure$DEPVAR
exog    <- model_structure$EXOG

reg_formula <- as.formula(paste(dep_var, " ~ ", exog, sep=""))
print(reg_formula)

# Run Regression
ols_model <- lm(reg_formula, reg_data)
summary(ols_model)

# Save output
list.save(ols_model, opt$out)
