#' gen_reg_vars.R
#'
#' contributors: @lachlandeer, @julianlanger
#'
#' Construct variables needed to run regressions
#'

# Libraries
library(optparse)
library(rjson)
library(readr)
library(dplyr)

 # CLI parsing
option_list = list(
    make_option(c("-d", "--data"),
                type = "character",
                default = NULL,
                help = "a csv file name",
                metavar = "character"),
    make_option(c("-p", "--param"),
                type = "numeric",
                default = 0.05,
                help = "Solow's Constant, as a numeric [default = %default]",
                metavar = "numeric"),
	make_option(c("-o", "--out"),
                type = "character",
                default = "out.csv",
                help = "output file name [default = %default]",
                metavar = "character")
);

opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

if (is.null(opt$data)){
  print_help(opt_parser)
  stop("Input data must be provided", call. = FALSE)
}

# Load data
print("Loading data")
mrw_data <- read_csv(opt$data)
solow_const <- as.numeric(opt$param)

# Generate Variables
print("Creating Variables")
mrw_data <- mrw_data %>%
                  mutate(ln_gdp_85 = log(gdp_85),
                         ln_gdp_60 = log(gdp_60),
                         ln_gdp_growth = ln_gdp_85 - ln_gdp_60,
                         ln_inv_gdp = log(inv_gdp/100),
                         non_oil = factor(non_oil),
                         intermediate = factor(intermediate),
                         oecd = factor(oecd),
                         ln_ndg = log(pop_growth_60_85/100 +
                                        solow_const),
                         ln_school = log(school/100)) %>%
                  select(country, ln_gdp_85, ln_gdp_60, ln_inv_gdp,
                         non_oil, intermediate, oecd,
                         ln_ndg, ln_school, gdp_growth_60_85, ln_gdp_growth)

# Save output
print("saving output")
write_csv(mrw_data, opt$out)
