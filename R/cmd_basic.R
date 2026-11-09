check_command <- function(options, turns) {
  turn_count <- length(turns)
  token_count <- total_tokens(turns)
  out <- paste0(
    "ok, ", plural(turn_count, "turn", "turns"), ", ",
    plural(token_count, "token", "tokens"), "\n"
  )
  reply(0L, out, "")
}

share_command <- function(options, turns) {
  totals <- role_totals(turns)
  total <- sum(totals)
  present <- totals > 0
  occurring_roles <- names(totals)[present]
  occurring_totals <- totals[present]
  tenths <- (occurring_totals * 2000 + total) %/% (2 * total)
  percentages <- paste0(tenths %/% 10, ".", tenths %% 10, "%")
  role_lines <- paste0(occurring_roles, " ", sprintf("%.0f", occurring_totals), " ", percentages)
  out <- paste0(paste(c(role_lines, paste0("total ", sprintf("%.0f", total))), collapse = "\n"), "\n")
  reply(0L, out, "")
}
