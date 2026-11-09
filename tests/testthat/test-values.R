rows <- list(
  list(c("fit", "--budget", "0"), "", 2, "", "turntrim: bad value for --budget\n"),
  list(c("fit", "--budget", "007"), "", 2, "", "turntrim: bad value for --budget\n"),
  list(c("fit", "--budget", "10000000"), "", 2, "", "turntrim: bad value for --budget\n"),
  list(c("fit", "--budget", "1.5"), "", 2, "", "turntrim: bad value for --budget\n"),
  list(c("fit", "--budget", ""), "", 2, "", "turntrim: bad value for --budget\n"),
  list(c("drop", "--budget", "5", "--keep-last", "41"), "", 2, "", "turntrim: bad value for --keep-last\n"),
  list(c("drop", "--budget", "5", "--keep-last", "01"), "", 2, "", "turntrim: bad value for --keep-last\n"),
  list(c("fit", "--budget", "5", "--keep-last", "-1"), "", 2, "", "turntrim: bad value for --keep-last\n"),
  list(c("chunks", "--max", "0"), "", 2, "", "turntrim: bad value for --max\n"),
  list(c("cost", "--price-in", "100001", "--price-out", "1"), "", 2, "", "turntrim: bad value for --price-in\n"),
  list(c("cost", "--price-in", "1", "--price-out", "x"), "", 2, "", "turntrim: bad value for --price-out\n"),
  list(c("cost", "--price-in", "007", "--price-out", "1"), "", 2, "", "turntrim: bad value for --price-in\n"),
  list(c("fit", "--budget", "9999999"), "user 5\n", 0, "1 keep\nkept 1 of 1 turns, 5 tokens\n", ""),
  list(c("fit", "--budget", "5", "--keep-last", "40"), "user 5\n", 0, "1 keep\nkept 1 of 1 turns, 5 tokens\n", ""),
  list(c("cost", "--price-in", "100000", "--price-out", "100000"), "user 999999\n", 0, "input 999999 tokens\noutput 0 tokens\ncost $999.999000\n", "")
)

check_rows(rows)
