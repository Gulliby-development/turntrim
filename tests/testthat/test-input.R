rows <- list(
  list(c("check"), "", 1, "", "turntrim: no turns\n"),
  list(c("check"), "\n", 1, "", "turntrim: no turns\n"),
  list(c("check"), "# only\n\n   \n", 1, "", "turntrim: no turns\n"),
  list(c("check"), "user 5", 0, "ok, 1 turn, 5 tokens\n", ""),
  list(c("check"), "user 5\ntool 6", 0, "ok, 2 turns, 11 tokens\n", ""),
  list(c("check"), "user 5\r\ntool 6\r\n", 0, "ok, 2 turns, 11 tokens\n", ""),
  list(c("check"), "user\n", 1, "", "turntrim: line 1: expected ROLE TOKENS [pin]\n"),
  list(c("check"), "user 5 pin extra\n", 1, "", "turntrim: line 1: expected ROLE TOKENS [pin]\n"),
  list(c("check"), "User 5\n", 1, "", "turntrim: line 1: bad role User\n"),
  list(c("check"), "user 0\n", 1, "", "turntrim: line 1: bad tokens 0\n"),
  list(c("check"), "user 05\n", 1, "", "turntrim: line 1: bad tokens 05\n"),
  list(c("check"), "user 1000000\n", 1, "", "turntrim: line 1: bad tokens 1000000\n"),
  list(c("check"), "user 5 keep\n", 1, "", "turntrim: line 1: bad flag keep\n"),
  list(c("check"), "  user\t5  \n", 0, "ok, 1 turn, 5 tokens\n", ""),
  list(c("check"), "# c\ntool 6 pin\nfrob 5\nuser x\n", 1, "", "turntrim: line 3: bad role frob\n"),
  list(c("check"), "user 5\n\ntool x\nbad\n", 1, "", "turntrim: line 3: bad tokens x\n"),
  list(c("check"), "user 5 pin\nassistant 7 pin\n", 0, "ok, 2 turns, 12 tokens\n", ""),
  list(c("check"), "system 1\n#user x\n", 0, "ok, 1 turn, 1 token\n", "")
)

check_rows(rows)
