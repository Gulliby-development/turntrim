rows <- list(
  list(c("check"), "user 1\n", 0, "ok, 1 turn, 1 token\n", ""),
  list(c("check"), "user 5\ntool 6\n", 0, "ok, 2 turns, 11 tokens\n", ""),
  list(c("check"), "system 3\nuser 4\nassistant 5\n", 0, "ok, 3 turns, 12 tokens\n", ""),
  list(c("check"), "user 999999\nuser 999999\n", 0, "ok, 2 turns, 1999998 tokens\n", ""),
  list(c("check"), "# a\nuser 5\n# b\n", 0, "ok, 1 turn, 5 tokens\n", ""),
  list(c("check"), "assistant 1 pin\n", 0, "ok, 1 turn, 1 token\n", "")
)

check_rows(rows)
