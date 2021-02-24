#' build_slides.R
#'
#' contributors: @lachlandeer
#'
#' Compiles a beamer slides from Rmarkdown
#'

# Libraries
library(optparse)

# CLI parsing
option_list = list(
   make_option(c("-i", "--index"),
               type = "character",
               default = "src/slides/slides.Rmd",
               help = "Name of rmarkdown file that contains slide content",
               metavar = "character"),
   make_option(c("-o", "--output"),
               type = "character",
               default = "out/slides/slides.pdf",
               help = "Name of pdf file output is saved to",
               metavar = "character")
)


opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

# Process Input
current_dir <- getwd()
slide_dir   <- dirname(opt$index)
slide_index <- basename(opt$index) 
out_file    <- opt$output

# Print Messages to help debug
message("Going to build slides")
message("Current Working Directory: ", current_dir)

## we need this so the build runs successfully,
## bookdown likes to run from the same directory as where the files located
message("Setting Working Directory to where sldies is located: ", slide_dir)
setwd(slide_dir)
message("Working Directory successfully changed to: ", slide_dir)
message("Building slides from index file named ", slide_index)

# Build file
rmarkdown::render(input = slide_index, 
            output_file = here::here(out_file), 
            quiet=FALSE
            )
