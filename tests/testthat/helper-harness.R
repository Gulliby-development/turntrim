# The helper of the row files: each row is list(args, input, status, out, err) or, for check_reads, list(args, "", reads, "", "").
check_rows <- function(rows) {
  for (index in seq_along(rows)) {
    row <- rows[[index]]
    test_that(paste("row", index), {
      answer <- run_cli(row[[1L]], row[[2L]])
      expect_equal(
        list(answer$status, answer$out, answer$err),
        list(row[[3L]], row[[4L]], row[[5L]])
      )
    })
  }
}

check_reads <- function(rows) {
  for (index in seq_along(rows)) {
    row <- rows[[index]]
    test_that(paste("row", index), {
      expect_equal(reads_stdin(row[[1L]]), row[[3L]] == 1)
    })
  }
}
