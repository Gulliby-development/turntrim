# The text of an amount in millionths of a dollar: format_micro(1234567) is "$1.234567".
format_micro <- function(micro) {
  whole <- micro %/% 1000000
  paste0("$", sprintf("%.0f", whole), ".", sprintf("%06.0f", micro %% 1000000))
}
