rows <- list(
  list(c("fit", "--budget", "1000"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 keep\n3 keep\n4 keep\n5 keep\nkept 5 of 5 turns, 800 tokens\n", ""),
  list(c("fit", "--budget", "400"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 drop\n3 drop\n4 keep\n5 keep\nkept 3 of 5 turns, 380 tokens\n", ""),
  list(c("fit", "--budget", "300"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 drop\n3 drop\n4 drop\n5 keep\nkept 2 of 5 turns, 300 tokens\n", ""),
  list(c("fit", "--budget", "350", "--keep-last", "1"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 drop\n3 drop\n4 drop\n5 keep\nkept 2 of 5 turns, 300 tokens\n", ""),
  list(c("fit", "--budget", "700", "--keep-last", "2"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "1 keep\n2 drop\n3 keep\n4 keep\n5 keep\nkept 4 of 5 turns, 680 tokens\n", ""),
  list(c("fit", "--budget", "200"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "1 keep\n2 drop\n3 drop\n4 drop\n5 drop\n6 keep\nkept 2 of 6 turns, 190 tokens\n", ""),
  list(c("fit", "--budget", "400", "--keep-last", "1"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "1 keep\n2 keep\n3 keep\n4 keep\n5 keep\n6 keep\nkept 6 of 6 turns, 340 tokens\n", ""),
  list(c("fit", "--budget", "150"), "user 100\ntool 50 pin\nuser 100\n", 0, "1 drop\n2 keep\n3 keep\nkept 2 of 3 turns, 150 tokens\n", ""),
  list(c("fit", "--budget", "340", "--keep-last", "9"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "1 keep\n2 keep\n3 keep\n4 keep\n5 keep\n6 keep\nkept 6 of 6 turns, 340 tokens\n", ""),
  list(c("fit", "--budget", "100"), "system 100\nuser 1\n", 0, "1 keep\n2 drop\nkept 1 of 2 turns, 100 tokens\n", "")
)

check_rows(rows)

refusals <- list(
  list(c("fit", "--budget", "40"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 1, "", "turntrim: fixed turns need 50 tokens, budget is 40\n"),
  list(c("fit", "--budget", "49"), "system 50\nuser 1\n", 1, "", "turntrim: fixed turns need 50 tokens, budget is 49\n"),
  list(c("fit", "--budget", "100"), "system 60\nuser 1 pin\nassistant 50 pin\n", 1, "", "turntrim: fixed turns need 111 tokens, budget is 100\n"),
  list(c("fit", "--budget", "400", "--keep-last", "3"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 1, "", "turntrim: last 3 turns do not fit: need 680 tokens, budget is 400\n"),
  list(c("fit", "--budget", "340", "--keep-last", "2"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 1, "", "turntrim: last 2 turns do not fit: need 380 tokens, budget is 340\n"),
  list(c("fit", "--budget", "100", "--keep-last", "1"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 1, "", "turntrim: last 1 turns do not fit: need 190 tokens, budget is 100\n")
)

check_rows(refusals)
