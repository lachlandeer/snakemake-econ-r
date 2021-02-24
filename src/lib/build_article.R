#' build_article.R
#'
#' contributors: @lachlandeer
#'
#' Compiles a bookdown project
#'

# Libraries
library(optparse)

# CLI parsing
option_list = list(
   make_option(c("-i", "--index"),
               type = "character",
               default = "src/paper/index.Rmd",
               help = "Name of rmarkdown file where paper metadata is located",
               metavar = "character")
)

opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

# Process Input
current_dir <- getwd()
paper_dir  <- dirname(opt$index)
paper_index <- basename(opt$index) 

# Print Messages to help debug
message("Going to build bookdown project")
message("Current Working Directory: ", current_dir)

## we need this so the build runs successfully,
## bookdown likes to run from the same directory as where the files located
message("Setting Working Directory to where paper is located: ", paper_dir)
setwd(paper_dir)
message("Working Directory successfully changed to: ", paper_dir)
message("Building Paper from index file named ", paper_index)

## Build!
message("Building paper with bookdown")
bookdown::render_book(paper_index, 'bookdown::pdf_book')
