rows <- list(
  list(c("drop", "--budget", "1000"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "none\n", ""),
  list(c("drop", "--budget", "400"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "2 3\n", ""),
  list(c("drop", "--budget", "300"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "2 3 4\n", ""),
  list(c("drop", "--budget", "350", "--keep-last", "1"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "2 3 4\n", ""),
  list(c("drop", "--budget", "320"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "2 3 4\n", ""),
  list(c("drop", "--budget", "200"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "2 3 4 5\n", ""),
  list(c("drop", "--budget", "400", "--keep-last", "1"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "none\n", ""),
  list(c("drop", "--budget", "55"), "user 30\nuser 30\nuser 30\n", 0, "1 2\n", ""),
  list(c("drop", "--budget", "90"), "user 30\ntool 30 pin\nuser 30\nuser 30\n", 0, "1\n", "")
)

check_rows(rows)

refusals <- list(
  list(c("drop", "--budget", "49"), "system 50\n", 1, "", "turntrim: fixed turns need 50 tokens, budget is 49\n"),
  list(c("drop", "--budget", "10"), "user 5 pin\nuser 6 pin\n", 1, "", "turntrim: fixed turns need 11 tokens, budget is 10\n"),
  list(c("drop", "--budget", "100", "--keep-last", "1"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 1, "", "turntrim: last 1 turns do not fit: need 300 tokens, budget is 100\n"),
  list(c("drop", "--budget", "100", "--keep-last", "4"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 1, "", "turntrim: last 4 turns do not fit: need 300 tokens, budget is 100\n")
)

check_rows(refusals)
