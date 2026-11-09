# Validate command words and options once so stdin eligibility and dispatch agree.
validate_cli <- function(args) {
  if (length(args) == 0L) {
    return(list(terminal = reply(2L, "", usage_text)))
  }

  command <- args[[1L]]
  if (command %in% c("help", "-h", "--help")) {
    return(list(terminal = reply(0L, usage_text, "")))
  }
  if (identical(command, "--version")) {
    return(list(terminal = reply(0L, paste0("turntrim ", turntrim_version, "\n"), "")))
  }

  entries <- command_table
  known <- vapply(entries, function(entry) entry$name, character(1L))
  if (!(command %in% known)) {
    fail(2L, paste0("unknown command ", command))
  }
  entry <- entries[[match(command, known)]]
  options <- list()
  seen <- character(0)
  index <- 2L

  while (index <= length(args)) {
    word <- args[[index]]
    if (!startsWith(word, "-") || identical(word, "-")) {
      fail(2L, paste0("unexpected argument ", word))
    }
    if (!(word %in% option_names)) {
      fail(2L, paste0("unknown option ", word))
    }
    if (!(word %in% entry$accepts)) {
      fail(2L, paste0("option ", word, " is not valid for ", command))
    }
    if (word %in% seen) {
      fail(2L, paste0("given twice: ", word))
    }
    if (index == length(args)) {
      fail(2L, paste0("missing value for ", word))
    }

    value <- args[[index + 1L]]
    limits <- switch(
      word,
      "--budget" = c(1, 9999999),
      "--max" = c(1, 9999999),
      "--keep-last" = c(0, 40),
      "--price-in" = c(0, 100000),
      "--price-out" = c(0, 100000)
    )
    if (!grepl("^(0|[1-9][0-9]*)$", value) || nchar(value, type = "chars") > 7L ||
          as.numeric(value) < limits[[1L]] || as.numeric(value) > limits[[2L]]) {
      fail(2L, paste0("bad value for ", word))
    }

    option_name <- switch(
      word,
      "--budget" = "budget",
      "--keep-last" = "keep_last",
      "--max" = "max",
      "--price-in" = "price_in",
      "--price-out" = "price_out"
    )
    options[[option_name]] <- as.integer(value)
    seen <- c(seen, word)
    index <- index + 2L
  }

  for (required in entry$requires) {
    if (!(required %in% seen)) {
      fail(2L, paste0("missing ", required))
    }
  }
  if (command %in% c("fit", "drop") && !("keep_last" %in% names(options))) {
    options$keep_last <- 0L
  }

  list(terminal = NULL, command = command, entry = entry, options = options)
}

run_cli <- function(args, input) {
  tryCatch(
    {
      parsed <- validate_cli(args)
      if (!is.null(parsed$terminal)) {
        return(parsed$terminal)
      }
      turns <- read_turns(input)
      handler <- get(parsed$entry$handler, mode = "function", inherits = TRUE)
      handler(parsed$options, turns)
    },
    turntrim_failure = function(condition) {
      reply(
        condition$status,
        "",
        paste0("turntrim: ", condition$message, "\n")
      )
    }
  )
}

reads_stdin <- function(args) {
  tryCatch(
    {
      parsed <- validate_cli(args)
      is.null(parsed$terminal)
    },
    turntrim_failure = function(condition) FALSE
  )
}
