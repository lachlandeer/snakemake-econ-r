# knit_beamer
#
# this script takes an Rmd file command line argument
# and complies it using knitr
#
#
# Author: @lachlandeer
#

# --- Command Line Unpack --- #
args     <- commandArgs(trailingOnly = TRUE)
rmd_file <- basename(args[1])
out_file <- args[2]

# --- ---- #
slide_dir <- "src/slides"

message("Setting Working Directory to where paper is located:", slide_dir)
setwd(slide_dir)

message("Working Directory successfully changed to:", getwd())

# --- Build file --- #
rmarkdown::render(input = rmd_file, output_file = here::here( out_file), quiet=FALSE)
