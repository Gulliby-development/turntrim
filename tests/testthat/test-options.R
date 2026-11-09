rows <- list(
  list(c("check", "extra"), "", 2, "", "turntrim: unexpected argument extra\n"),
  list(c("check", "-"), "", 2, "", "turntrim: unexpected argument -\n"),
  list(c("check", ""), "", 2, "", "turntrim: unexpected argument \n"),
  list(c("check", "--bogus"), "", 2, "", "turntrim: unknown option --bogus\n"),
  list(c("share", "--budget", "5"), "", 2, "", "turntrim: option --budget is not valid for share\n"),
  list(c("fit", "--max", "5"), "", 2, "", "turntrim: option --max is not valid for fit\n"),
  list(c("fit", "--budget", "5", "--budget", "5"), "", 2, "", "turntrim: given twice: --budget\n"),
  list(c("fit", "--budget"), "", 2, "", "turntrim: missing value for --budget\n"),
  list(c("fit", "-x", "--budget"), "", 2, "", "turntrim: unknown option -x\n"),
  list(c("chunks", "--max"), "", 2, "", "turntrim: missing value for --max\n"),
  list(c("cost", "--price-in", "1", "--bogus"), "", 2, "", "turntrim: unknown option --bogus\n"),
  list(c("drop", "--keep-last", "2"), "", 2, "", "turntrim: missing --budget\n"),
  list(c("cost", "--price-out", "5"), "", 2, "", "turntrim: missing --price-in\n"),
  list(c("chunks", "--price-in", "5"), "", 2, "", "turntrim: option --price-in is not valid for chunks\n"),
  list(c("fit", "--keep-last", "1", "--budget", "500"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 drop\n3 drop\n4 keep\n5 keep\nkept 3 of 5 turns, 380 tokens\n", ""),
  list(c("drop", "--keep-last", "0", "--budget", "100"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "2 3 4 5\n", ""),
  list(c("cost", "--price-out", "10", "--price-in", "20"), "user 1000\nassistant 1000\n", 0, "input 1000 tokens\noutput 1000 tokens\ncost $0.000300\n", ""),
  list(c("chunks", "--max", "100"), "user 100\ntool 1\n", 0, "chunk 1: turn 1, 100 tokens\nchunk 2: turn 2, 1 token\n2 chunks\n", "")
)

check_rows(rows)
