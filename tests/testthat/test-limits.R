rows <- list(
  list(c("check"), "user 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\n", 0, "ok, 40 turns, 40 tokens\n", ""),
  list(c("check"), "user 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\n", 1, "", "turntrim: input is too long (max 40 lines)\n"),
  list(c("check"), "# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\nuser 1\n", 1, "", "turntrim: input is too long (max 40 lines)\n"),
  list(c("check"), "user 999999\n", 0, "ok, 1 turn, 999999 tokens\n", ""),
  list(c("check"), "user 1000000\n", 1, "", "turntrim: line 1: bad tokens 1000000\n"),
  list(c("drop", "--budget", "40"), "user 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\nuser 1\n", 0, "none\n", ""),
  list(c("chunks", "--max", "40"), "tool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\ntool 1\n", 0, "chunk 1: turns 1-40, 40 tokens\n1 chunk\n", ""),
  list(c("cost", "--price-in", "1", "--price-out", "1"), "user 999999\nassistant 999999\n", 0, "input 999999 tokens\noutput 999999 tokens\ncost $0.020000\n", "")
)

check_rows(rows)
