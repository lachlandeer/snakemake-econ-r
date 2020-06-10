# knit_beamer
#
# this script takes an Rmd file command line argument
# and complies it using knitr
#
# Compilation happens in the directory where the Rmd file is located since
# this seems to be a bit of a philosophy, and then we move the file to the
# desired output location
#
# Author: @lachlandeer
#

# --- Command Line Unpack --- #
args     <- commandArgs(trailingOnly = TRUE)
rmd_file <- args[1]
out_file <- args[2]
#out_file = basename(args[2])
#out_path = dirname(args[2])

print(out_file)
print("working directory is")
getwd()
#print(out_path)

# --- Path where we want our pdf to end up --- #
# final_pdf = here::here(out_path, out_file)
# print(final_pdf)

# --- Build file --- #
## knit R likes to build to its own directory, let's assemble what the
## name of the output will be
# tmp_pdf = here::here(dirname(rmd_file), out_file)
# print(tmp_pdf)
## knit
rmarkdown::render(input = rmd_file, output_file = out_file, quiet=FALSE)
