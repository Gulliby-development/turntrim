rows <- list(
  list(c("help"), "", 0, "usage: turntrim check\n       turntrim share\n       turntrim fit --budget N [--keep-last K]\n       turntrim drop --budget N [--keep-last K]\n       turntrim chunks --max N\n       turntrim cost --price-in P --price-out Q\n", ""),
  list(c("-h"), "", 0, "usage: turntrim check\n       turntrim share\n       turntrim fit --budget N [--keep-last K]\n       turntrim drop --budget N [--keep-last K]\n       turntrim chunks --max N\n       turntrim cost --price-in P --price-out Q\n", ""),
  list(character(0), "", 2, "", "usage: turntrim check\n       turntrim share\n       turntrim fit --budget N [--keep-last K]\n       turntrim drop --budget N [--keep-last K]\n       turntrim chunks --max N\n       turntrim cost --price-in P --price-out Q\n"),
  list(c("--help", "--bogus"), "", 0, "usage: turntrim check\n       turntrim share\n       turntrim fit --budget N [--keep-last K]\n       turntrim drop --budget N [--keep-last K]\n       turntrim chunks --max N\n       turntrim cost --price-in P --price-out Q\n", ""),
  list(c("--version"), "", 0, "turntrim 0.1.0\n", ""),
  list(c("--version", "x"), "", 0, "turntrim 0.1.0\n", ""),
  list(c("frob"), "", 2, "", "turntrim: unknown command frob\n"),
  list(c(""), "", 2, "", "turntrim: unknown command \n"),
  list(c("Check"), "", 2, "", "turntrim: unknown command Check\n"),
  list(c("-H"), "", 2, "", "turntrim: unknown command -H\n")
)

check_rows(rows)
