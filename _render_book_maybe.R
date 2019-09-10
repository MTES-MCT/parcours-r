#!/usr/bin/env Rscript

(function() {
  
  "Usage: 
  render_book_maybe.R [-h] [-x] [--input=FILE] [--output_format=FORMAT] [--config_file=FILE] [--output_dir=DIR] [<dir>]
  
  -h --help                         show this help text
  -x --usage                        show help and short example usage
  dir                               directory of bookdown source files, current directory if omitted
  -i FILE --input=FILE              input filename, default: index.Rmd
  -f FORMAT --output_format=FORMAT  output format passed to bookdown::render_book()
  -c FILE --config_file=FILE        configuration file in dir
  -o DIR --output_dir=DIR           output directory passed to bookdown::render_book(), default: _book" -> doc
  
  opt <- docopt::docopt(doc)
  
  if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
        render_book_maybe.R                             # render bookdown in current directory
        render_book_maybe.R dir                         # render bookdown in directory dir
        render_book_maybe.R --config_file=_bookdown.yml # specify the configuration file
        render_book_maybe.R -c _bookdown.yml            # specify the configuration file\n"
    )
    q("no")
  }
  
  input <- if (is.null(opt$input)) "index.Rmd" else opt$input
  wd <- if (is.null(opt$dir)) "." else opt$dir
  config_file <- if (is.null(opt$config_file)) "_bookdown.yml" else opt$config_file
  
  if (!dir.exists(wd)) {
    stop("The argument must be a path to a directory.", call. = FALSE)
  }
  owd <- setwd(wd)
  on.exit(setwd(owd))
  
  get_sha <- function(file) {
    sha <- system2("git", c("log", "-n", "1", "--pretty=format:%H", "--", file), stdout = TRUE)
    if (length(sha) < 1L) return("")
    sha
  }
  
  needs_build <- function(output_dir, config_file) {
    source_files <- bookdown:::source_files(all = TRUE)
    aux_files <- c(config_file, list.files(pattern = "^_output\\.yml$"))
    tracked_files <- c(source_files, aux_files)
    
    current_sha <- vapply(tracked_files, get_sha, character(1), USE.NAMES = FALSE)
    df <- as.data.frame(list(file = tracked_files, sha = current_sha), stringsAsFactors = FALSE)
    
    yes_build <- TRUE
    attr(yes_build, "sha") <- df
    
    if (!dir.exists(output_dir)) {
      message(output_dir, " does not exist. Bookdown needs to be built.")
      return(yes_build)
    }
    
    stored_sha <- file.path(output_dir, "sha.csv")
    if (file.exists(stored_sha)) {
      prev_sha <- read.csv(stored_sha, stringsAsFactors = FALSE)
    } else {
      message("Cannot find ", stored_sha, " file. Bookdown needs to be built.")
      return(yes_build)
    }
    
    if (!identical(colnames(prev_sha), c("file", "sha"))) {
      message(stored_sha, ": wrong file format.")
      return(yes_build)
    }
    
    merged <- merge(prev_sha, df, by.x = "file", by.y = "file", all = TRUE)
    if (isTRUE(all(merged$sha.x == merged$sha.y))) {
      return(FALSE)
    } else {
      message("Source files have changed.")
      return(yes_build)
    }
  }
  
  render_book_maybe <- function(
    input, output_format = NULL, ..., output_dir = NULL, 
    config_file = "_bookdown.yml", envir = globalenv()
  ) {
    bookdown:::opts$set(config = rmarkdown:::yaml_load_file(config_file))
    output_dir <- bookdown:::output_dirname(output_dir, create = FALSE)
    csv_path <- file.path(output_dir, "sha.csv")
    to_build <- needs_build(output_dir, config_file)
    
    if (to_build) {
      bookdown::render_book(input = input, 
                            output_format = output_format, 
                            output_dir = output_dir, 
                            config_file = config_file, 
                            envir = envir, 
                            ...)
      write.csv(attr(to_build, "sha"), csv_path, row.names = FALSE)
    }
    else {
      message("No source file have changed.")
    }
  }
  
  render_book_maybe(
    input = input, output_format = opt$output_format, 
    output_dir = opt$output_dir, config_file = config_file
  )
})()
