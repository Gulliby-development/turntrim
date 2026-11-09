rows <- list(
  list(c("chunks", "--max", "1000"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "chunk 1: turns 1-5, 800 tokens\n1 chunk\n", ""),
  list(c("chunks", "--max", "400"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "chunk 1: turns 1-2, 170 tokens\nchunk 2: turns 3-4, 380 tokens\nchunk 3: turn 5, 250 tokens\n3 chunks\n", ""),
  list(c("chunks", "--max", "300"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "chunk 1: turns 1-2, 170 tokens\nchunk 2: turn 3, 300 tokens\nchunk 3: turn 4, 80 tokens\nchunk 4: turn 5, 250 tokens\n4 chunks\n", ""),
  list(c("chunks", "--max", "120"), "user 100\nuser 20\nuser 100\nuser 21\n", 0, "chunk 1: turns 1-2, 120 tokens\nchunk 2: turn 3, 100 tokens\nchunk 3: turn 4, 21 tokens\n3 chunks\n", ""),
  list(c("chunks", "--max", "10"), "user 5\ntool 5\nuser 5\ntool 5\nuser 5\n", 0, "chunk 1: turns 1-2, 10 tokens\nchunk 2: turns 3-4, 10 tokens\nchunk 3: turn 5, 5 tokens\n3 chunks\n", ""),
  list(c("chunks", "--max", "100"), "user 100\n", 0, "chunk 1: turn 1, 100 tokens\n1 chunk\n", ""),
  list(c("chunks", "--max", "99"), "user 100\n", 1, "", "turntrim: turn 1 has 100 tokens, more than 99\n"),
  list(c("chunks", "--max", "10"), "user 5\ntool 11\n", 1, "", "turntrim: turn 2 has 11 tokens, more than 10\n"),
  list(c("chunks", "--max", "7"), "user 3\nuser 4\nuser 4\nuser 3\n", 0, "chunk 1: turns 1-2, 7 tokens\nchunk 2: turns 3-4, 7 tokens\n2 chunks\n", ""),
  list(c("chunks", "--max", "9999999"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "chunk 1: turns 1-6, 340 tokens\n1 chunk\n", "")
)

check_rows(rows)
