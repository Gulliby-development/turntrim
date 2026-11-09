rows <- list(
  list(c("cost", "--price-in", "300", "--price-out", "1500"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "input 250 tokens\noutput 550 tokens\ncost $0.009000\n", ""),
  list(c("cost", "--price-in", "300", "--price-out", "1500"), "user 1\n", 0, "input 1 token\noutput 0 tokens\ncost $0.000003\n", ""),
  list(c("cost", "--price-in", "0", "--price-out", "0"), "system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n", 0, "input 250 tokens\noutput 550 tokens\ncost $0.000000\n", ""),
  list(c("cost", "--price-in", "100", "--price-out", "0"), "user 999999\n", 0, "input 999999 tokens\noutput 0 tokens\ncost $0.999999\n", ""),
  list(c("cost", "--price-in", "0", "--price-out", "100"), "assistant 999999\n", 0, "input 0 tokens\noutput 999999 tokens\ncost $0.999999\n", ""),
  list(c("cost", "--price-in", "1", "--price-out", "1"), "tool 49\n", 0, "input 49 tokens\noutput 0 tokens\ncost $0.000000\n", ""),
  list(c("cost", "--price-in", "1", "--price-out", "1"), "tool 50\n", 0, "input 50 tokens\noutput 0 tokens\ncost $0.000001\n", ""),
  list(c("cost", "--price-in", "250", "--price-out", "1000"), "system 100 pin\nuser 40\nassistant 60\ntool 30\nuser 20\nassistant 90\n", 0, "input 190 tokens\noutput 150 tokens\ncost $0.001975\n", ""),
  list(c("cost", "--price-in", "3", "--price-out", "3"), "user 1\nassistant 1\n", 0, "input 1 token\noutput 1 token\ncost $0.000000\n", ""),
  list(c("cost", "--price-in", "100000", "--price-out", "100000"), "user 100000\n", 0, "input 100000 tokens\noutput 0 tokens\ncost $100.000000\n", "")
)

check_rows(rows)
