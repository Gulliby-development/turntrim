retention_decision <- function(options, turns) {
  tokens <- turn_tokens(turns)
  turn_roles <- vapply(turns, function(turn) turn$role, character(1L))
  turn_pins <- vapply(turns, function(turn) turn$pin, logical(1L))
  fixed <- turn_roles == "system" | turn_pins
  fixed_total <- sum(tokens[fixed])
  budget <- options$budget
  keep_last <- options$keep_last

  if (fixed_total > budget) {
    fail(1L, sprintf("fixed turns need %.0f tokens, budget is %.0f", fixed_total, budget))
  }

  free_indices <- which(!fixed)
  protected_count <- min(keep_last, length(free_indices))
  protected_indices <- if (protected_count == 0L) {
    integer(0)
  } else {
    tail(free_indices, protected_count)
  }
  protected <- rep(FALSE, length(turns))
  protected[protected_indices] <- TRUE
  protected_total <- sum(tokens[protected])
  combined_total <- fixed_total + protected_total
  if (combined_total > budget) {
    fail(
      1L,
      sprintf(
        "last %.0f turns do not fit: need %.0f tokens, budget is %.0f",
        keep_last,
        combined_total,
        budget
      )
    )
  }

  keep <- fixed | protected
  remaining_indices <- free_indices[!protected[free_indices]]
  remaining <- budget - combined_total
  for (index in rev(remaining_indices)) {
    if (tokens[[index]] > remaining) {
      break
    }
    keep[[index]] <- TRUE
    remaining <- remaining - tokens[[index]]
  }

  list(keep = keep, tokens = tokens)
}

fit_command <- function(options, turns) {
  decision <- retention_decision(options, turns)
  keep <- decision$keep
  tokens <- decision$tokens
  turn_numbers <- seq_along(turns)
  decision_lines <- paste0(turn_numbers, ifelse(keep, " keep", " drop"))
  kept_count <- sum(keep)
  kept_tokens <- sum(tokens[keep])
  summary <- paste0(
    "kept ", sprintf("%.0f", kept_count), " of ", sprintf("%.0f", length(turns)),
    " turns, ", plural(kept_tokens, "token", "tokens"), "\n"
  )
  out <- paste0(paste(c(decision_lines, summary), collapse = "\n"))
  reply(0L, out, "")
}

drop_command <- function(options, turns) {
  decision <- retention_decision(options, turns)
  dropped <- which(!decision$keep)
  out <- if (length(dropped) == 0L) {
    "none\n"
  } else {
    paste0(paste(dropped, collapse = " "), "\n")
  }
  reply(0L, out, "")
}
