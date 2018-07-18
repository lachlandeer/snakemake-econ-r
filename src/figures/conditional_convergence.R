#' conditional_convergence.R
#'
#' contributors: @lachlandeer, @julianlanger
#'
#' Plot conditional convergence for intermediate countries
#'

# Libraries
library(optparse)
library(rjson)
library(readr)
library(ggplot2)
library(tibble)

# CLI parsing
option_list = list(
   make_option(c("-d", "--data"),
               type = "character",
               default = NULL,
               help = "a csv file name",
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
if (is.null(opt$subset)){
 print_help(opt_parser)
 stop("A subsetting condition", call. = FALSE)
}

# Load data
print("Loading data")
df <- read_csv(opt$data)

# Load Subset Condition
print("Loading Subsetting Condition")
data_filter <- fromJSON(file = opt$subset)

# Filter data
intermediate <- subset(df, eval(parse(text = data_filter$KEEP_CONDITION)))

# Partial out regressors:
y_p <- lm(ln_gdp_growth ~  ln_inv_gdp + ln_ndg, data = intermediate)$residuals
x_p <- lm(ln_gdp_60 ~  ln_inv_gdp + ln_ndg, data = intermediate)$residuals

plot_data <- tibble(y_p, x_p)

# Make plot_data
plt <- ggplot(plot_data, aes(x = x_p, y = y_p)) +
        geom_point(shape = 1) +
        geom_smooth(method = lm, se = FALSE, color = "red") +
        theme_bw() +
        ggtitle("B: Conditional on Saving and Population Growth") +
        ylab("Log Growth rate: 1960 - 85") +
        xlab("Log output per working age adult: 1960")

ggsave(opt$out, plt)
