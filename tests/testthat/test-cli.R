rows <- list(
  list(c("check"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "ok, 5 turns, 800 tokens\n", ""),
  list(c("share"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "system 50 6.3%\nuser 200 25.0%\nassistant 550 68.8%\ntotal 800\n", ""),
  list(c("check"), "user 1\n", 0, "ok, 1 turn, 1 token\n", ""),
  list(c("share"), "# note\nuser 5\n\ntool 5\n", 0, "user 5 50.0%\ntool 5 50.0%\ntotal 10\n", ""),
  list(c("fit", "--budget", "400"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 drop\n3 drop\n4 keep\n5 keep\nkept 3 of 5 turns, 380 tokens\n", ""),
  list(c("drop", "--budget", "400"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "2 3\n", ""),
  list(c("fit", "--budget", "600", "--keep-last", "1"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "1 keep\n2 keep\n3 keep\n4 keep\n5 keep\n6 keep\nkept 6 of 6 turns, 340 tokens\n", ""),
  list(c("drop", "--budget", "10"), "user 5\nuser 6\n", 0, "1\n", ""),
  list(c("chunks", "--max", "400"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "chunk 1: turns 1-2, 170 tokens\nchunk 2: turns 3-4, 380 tokens\nchunk 3: turn 5, 250 tokens\n3 chunks\n", ""),
  list(c("chunks", "--max", "1000"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "chunk 1: turns 1-6, 340 tokens\n1 chunk\n", ""),
  list(c("cost", "--price-in", "300", "--price-out", "1500"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "input 250 tokens\noutput 550 tokens\ncost $0.009000\n", ""),
  list(c("cost", "--price-in", "0", "--price-out", "0"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "input 190 tokens\noutput 150 tokens\ncost $0.000000\n", "")
)

check_rows(rows)
