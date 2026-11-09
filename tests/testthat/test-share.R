rows <- list(
  list(c("share"), "user 100\n", 0, "user 100 100.0%\ntotal 100\n", ""),
  list(c("share"), "user 1\nassistant 2\n", 0, "user 1 33.3%\nassistant 2 66.7%\ntotal 3\n", ""),
  list(c("share"), "system 50\nuser 120\nassistant 300\ntool 30\n", 0, "system 50 10.0%\nuser 120 24.0%\nassistant 300 60.0%\ntool 30 6.0%\ntotal 500\n", ""),
  list(c("share"), "tool 1\nuser 1\nsystem 1\n", 0, "system 1 33.3%\nuser 1 33.3%\ntool 1 33.3%\ntotal 3\n", ""),
  list(c("share"), "user 1\nuser 1\nassistant 1\n", 0, "user 2 66.7%\nassistant 1 33.3%\ntotal 3\n", ""),
  list(c("share"), "user 1\nassistant 999999\n", 0, "user 1 0.0%\nassistant 999999 100.0%\ntotal 1000000\n", ""),
  list(c("share"), "user 3\nassistant 3\ntool 3\nsystem 1\n", 0, "system 1 10.0%\nuser 3 30.0%\nassistant 3 30.0%\ntool 3 30.0%\ntotal 10\n", ""),
  list(c("share"), "user 1\ntool 7\n", 0, "user 1 12.5%\ntool 7 87.5%\ntotal 8\n", "")
)

check_rows(rows)
