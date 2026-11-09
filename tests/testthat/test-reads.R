rows <- list(
  list(c("check"), "", 1, "", ""),
  list(c("share"), "", 1, "", ""),
  list(c("fit", "--budget", "5"), "", 1, "", ""),
  list(c("drop", "--budget", "5", "--keep-last", "1"), "", 1, "", ""),
  list(c("chunks", "--max", "9"), "", 1, "", ""),
  list(c("cost", "--price-in", "1", "--price-out", "2"), "", 1, "", ""),
  list(c("help"), "", 0, "", ""),
  list(c("--help"), "", 0, "", ""),
  list(c("--version"), "", 0, "", ""),
  list(character(0), "", 0, "", ""),
  list(c("frob"), "", 0, "", ""),
  list(c("check", "extra"), "", 0, "", ""),
  list(c("fit"), "", 0, "", ""),
  list(c("chunks"), "", 0, "", ""),
  list(c("cost", "--price-in", "1"), "", 0, "", ""),
  list(c("check", "--budget", "5"), "", 0, "", ""),
  list(c("fit", "--budget"), "", 0, "", ""),
  list(c("fit", "--budget", "0"), "", 0, "", ""),
  list(c("fit", "--budget", "5", "--budget", "6"), "", 0, "", ""),
  list(c("cost", "--price-out", "1", "--price-in", "1"), "", 1, "", ""),
  list(c("share", "-"), "", 0, "", ""),
  list(c("chunks", "--max", "9", "--keep-last", "1"), "", 0, "", "")
)

check_reads(rows)
