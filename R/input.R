split_input_lines <- function(text) {
  if (identical(text, "")) {
    return(character(0))
  }

  newline_positions <- gregexpr("\n", text, fixed = TRUE)[[1L]]
  if (newline_positions[[1L]] == -1L) {
    return(text)
  }

  starts <- c(1L, newline_positions + 1L)
  ends <- c(newline_positions - 1L, nchar(text, type = "chars"))
  if (ends[[length(ends)]] < starts[[length(starts)]]) {
    starts <- starts[-length(starts)]
    ends <- ends[-length(ends)]
  }

  vapply(
    seq_along(starts),
    function(index) {
      if (ends[[index]] < starts[[index]]) {
        ""
      } else {
        substr(text, starts[[index]], ends[[index]])
      }
    },
    character(1L),
    USE.NAMES = FALSE
  )
}

read_turns <- function(text) {
  lines <- split_input_lines(text)
  if (length(lines) > max_lines) {
    fail(1L, sprintf("input is too long (max %d lines)", max_lines))
  }

  turns <- list()
  for (line_number in seq_along(lines)) {
    line <- lines[[line_number]]
    if (endsWith(line, "\r")) {
      line <- substr(line, 1L, nchar(line, type = "chars") - 1L)
    }

    trimmed <- gsub("^[ \t]+|[ \t]+$", "", line, perl = TRUE)
    if (identical(trimmed, "") || startsWith(trimmed, "#")) {
      next
    }

    words <- strsplit(trimmed, "[ \t]+", perl = TRUE)[[1L]]
    if (length(words) < 2L || length(words) > 3L) {
      fail(
        1L,
        sprintf("line %d: expected ROLE TOKENS [pin]", line_number)
      )
    }

    role <- words[[1L]]
    if (!(role %in% roles)) {
      fail(1L, sprintf("line %d: bad role %s", line_number, role))
    }

    token_text <- words[[2L]]
    if (
      !grepl("^[1-9][0-9]{0,5}$", token_text) ||
        as.numeric(token_text) > max_tokens
    ) {
      fail(1L, sprintf("line %d: bad tokens %s", line_number, token_text))
    }

    pin <- FALSE
    if (length(words) == 3L) {
      flag <- words[[3L]]
      if (!identical(flag, "pin")) {
        fail(1L, sprintf("line %d: bad flag %s", line_number, flag))
      }
      pin <- TRUE
    }

    turns[[length(turns) + 1L]] <- list(
      role = role,
      tokens = as.numeric(token_text),
      pin = pin
    )
  }

  if (length(turns) == 0L) {
    fail(1L, "no turns")
  }

  turns
}
