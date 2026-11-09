chunks_command <- function(options, turns) {
  tokens <- turn_tokens(turns)
  oversized <- which(tokens > options$max)
  if (length(oversized) > 0L) {
    index <- oversized[[1L]]
    fail(
      1L,
      paste0(
        "turn ", sprintf("%.0f", index), " has ",
        sprintf("%.0f", tokens[[index]]), " tokens, more than ",
        sprintf("%.0f", options$max)
      )
    )
  }

  starts <- integer(0)
  ends <- integer(0)
  totals <- numeric(0)
  chunk_start <- 1L
  chunk_total <- 0
  for (index in seq_along(tokens)) {
    if (chunk_total + tokens[[index]] > options$max) {
      starts <- c(starts, chunk_start)
      ends <- c(ends, index - 1L)
      totals <- c(totals, chunk_total)
      chunk_start <- index
      chunk_total <- 0
    }
    chunk_total <- chunk_total + tokens[[index]]
  }
  starts <- c(starts, chunk_start)
  ends <- c(ends, length(tokens))
  totals <- c(totals, chunk_total)

  chunk_lines <- vapply(seq_along(starts), function(index) {
    chunk_label <- if (starts[[index]] == ends[[index]]) {
      paste0("turn ", sprintf("%.0f", starts[[index]]))
    } else {
      paste0(
        "turns ", sprintf("%.0f", starts[[index]]), "-",
        sprintf("%.0f", ends[[index]])
      )
    }
    paste0(
      "chunk ", sprintf("%.0f", index), ": ", chunk_label, ", ",
      plural(totals[[index]], "token", "tokens")
    )
  }, character(1))
  out <- paste0(
    paste(c(chunk_lines, plural(length(starts), "chunk", "chunks")), collapse = "\n"),
    "\n"
  )
  reply(0L, out, "")
}

cost_command <- function(options, turns) {
  totals <- role_totals(turns)
  input <- sum(totals[names(totals) != "assistant"])
  output <- totals[["assistant"]]
  micro <- (input * as.double(options$price_in) + output * as.double(options$price_out) + 50) %/% 100
  out <- paste0(
    "input ", plural(input, "token", "tokens"), "\n",
    "output ", plural(output, "token", "tokens"), "\n",
    "cost ", format_micro(micro), "\n"
  )
  reply(0L, out, "")
}
