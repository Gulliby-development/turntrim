rows <- list(
  list(c("share"), "system 1\n", 0, "system 1 100.0%\ntotal 1\n", ""),
  list(c("check"), "# nothing\n", 1, "", "turntrim: no turns\n"),
  list(c("share"), "user 1\nuser 1\nuser 1\n", 0, "user 3 100.0%\ntotal 3\n", ""),
  list(c("check"), "tool 1 pin\n", 0, "ok, 1 turn, 1 token\n", ""),
  list(c("fit", "--budget", "100"), "user 100\n", 0, "1 keep\nkept 1 of 1 turns, 100 tokens\n", ""),
  list(c("fit", "--budget", "99"), "user 100\n", 0, "1 drop\nkept 0 of 1 turns, 0 tokens\n", ""),
  list(c("drop", "--budget", "100"), "user 100\ntool 1\n", 0, "1\n", ""),
  list(c("drop", "--budget", "1000"), "user 1\n", 0, "none\n", ""),
  list(c("chunks", "--max", "5"), "user 5\n", 0, "chunk 1: turn 1, 5 tokens\n1 chunk\n", ""),
  list(c("chunks", "--max", "5"), "user 2\nuser 3\nuser 1\n", 0, "chunk 1: turns 1-2, 5 tokens\nchunk 2: turn 3, 1 token\n2 chunks\n", ""),
  list(c("cost", "--price-in", "1", "--price-out", "1"), "user 49\n", 0, "input 49 tokens\noutput 0 tokens\ncost $0.000000\n", ""),
  list(c("cost", "--price-in", "1", "--price-out", "1"), "user 50\n", 0, "input 50 tokens\noutput 0 tokens\ncost $0.000001\n", ""),
  list(c("chunks", "--max", "2"), "user 1\ntool 1\nuser 1\ntool 2\n", 0, "chunk 1: turns 1-2, 2 tokens\nchunk 2: turn 3, 1 token\nchunk 3: turn 4, 2 tokens\n3 chunks\n", "")
)

check_rows(rows)
