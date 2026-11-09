plural <- function(count, one, many) {
  noun <- if (count == 1) one else many
  paste0(sprintf("%.0f", count), " ", noun)
}
