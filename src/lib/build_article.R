current_dir <- getwd()
paper_dir   <- "src/paper"

message("Current Working Directory:", current_dir)

# we need this so the build runs successfully,
# bookdown likes to run from the same directory as where the files located
message("Setting Working Directory to where paper is located:", paper_dir)
setwd(paper_dir)

message("Working Directory successfully changed to:", paper_dir)

message("Building paper with bookdown")
bookdown::render_book('index.Rmd', 'bookdown::pdf_book')
