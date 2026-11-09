turn_tokens <- function(turns) {
  if (length(turns) == 0L) {
    return(numeric(0))
  }

  as.double(vapply(turns, function(turn) turn$tokens, numeric(1)))
}

total_tokens <- function(turns) {
  sum(turn_tokens(turns))
}

role_totals <- function(turns) {
  tokens <- turn_tokens(turns)
  turn_roles <- if (length(turns) == 0L) {
    character(0)
  } else {
    vapply(turns, function(turn) turn$role, character(1))
  }

  totals <- vapply(roles, function(role) sum(tokens[turn_roles == role]), numeric(1))
  names(totals) <- roles
  totals
}
