current_dir <- getwd()
paper_dir   <- "src/paper"

message("Current Working Directory:", current_dir)

message("Setting Working Directory to where paper is located:", paper_dir)
setwd(paper_dir)

message("Working Directory successfully changed to:", paper_dir)

message("Building paper with bookdown")
bookdown::render_book('index.Rmd', 'bookdown::pdf_book')
