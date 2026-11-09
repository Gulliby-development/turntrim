turntrim_version <- "0.1.0"
max_lines <- 40L
max_tokens <- 999999L
roles <- c("system", "user", "assistant", "tool")
option_names <- c("--budget", "--keep-last", "--max", "--price-in", "--price-out")

usage_text <- paste0(
  "usage: turntrim check\n",
  "       turntrim share\n",
  "       turntrim fit --budget N [--keep-last K]\n",
  "       turntrim drop --budget N [--keep-last K]\n",
  "       turntrim chunks --max N\n",
  "       turntrim cost --price-in P --price-out Q\n"
)

# One entry per command: its word, the function that runs it, the options it accepts and the
# options it requires (in the order that a missing one is reported).
command_table <- list(
  list(name = "check", handler = "check_command", accepts = character(0), requires = character(0)),
  list(name = "share", handler = "share_command", accepts = character(0), requires = character(0)),
  list(name = "fit", handler = "fit_command", accepts = c("--budget", "--keep-last"), requires = "--budget"),
  list(name = "drop", handler = "drop_command", accepts = c("--budget", "--keep-last"), requires = "--budget"),
  list(name = "chunks", handler = "chunks_command", accepts = "--max", requires = "--max"),
  list(name = "cost", handler = "cost_command", accepts = c("--price-in", "--price-out"), requires = c("--price-in", "--price-out"))
)

# A failure that ends the command: status 1 for the input and for a command, 2 for the command line.
fail <- function(status, message) {
  stop(structure(
    class = c("turntrim_failure", "error", "condition"),
    list(message = message, call = NULL, status = status)
  ))
}

reply <- function(status, out, err) {
  list(status = status, out = out, err = err)
}
