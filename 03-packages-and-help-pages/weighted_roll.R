weighted_roll <- function() {
  die <- 1:6
  
  dice <- sample(
    x = die,
    size = 2, 
    replace = TRUE,
    prob = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.3)
  )
  
  sum(dice)
}
