#!/usr/bin/env Rscript
arguments <- commandArgs()
script_arg <- arguments[startsWith(arguments, "--file=")]
script_path <- normalizePath(substring(script_arg[[1L]], 8L))
project_dir <- dirname(dirname(script_path))
sources <- list.files(file.path(project_dir, "R"), pattern = "[.]R$", full.names = TRUE)
for (source_path in sources[order(basename(sources), method = "radix")]) {
  source(source_path)
}

read_stdin <- function() {
  connection <- file("stdin", "rb")
  on.exit(close(connection))
  chunks <- list()
  repeat {
    chunk <- readBin(connection, what = "raw", n = 65536L)
    if (length(chunk) == 0L) {
      break
    }
    chunks[[length(chunks) + 1L]] <- chunk
  }
  rawToChar(do.call(c, c(list(raw(0)), chunks)))
}

args <- commandArgs(trailingOnly = TRUE)
input <- if (reads_stdin(args)) read_stdin() else ""
answer <- run_cli(args, input)
writeLines(answer$out, stdout(), sep = "", useBytes = TRUE)
writeLines(answer$err, stderr(), sep = "", useBytes = TRUE)
quit(save = "no", status = answer$status)
