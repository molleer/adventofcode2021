library("purrr")
input <- read.csv("./day7/input.txt")[1,]
silver <- function(input) {
  start <- max(input)
  len <- length(input)
  min_score <- sum(abs(input - start))
  
  for(i in seq(start-1, 0)) {
    next_min <- sum(abs(input - i))
    if(next_min < min_score) {
      min_score <- next_min
    }
  }
  return(min_score)
}

gold <- function(input) {
  start <- max(input)
  len <- length(input)
  min_score <- sum(abs(input - start)*(abs(input-start)+1)/2)
  
  for(i in seq(start-1, 0)) {
    next_min <- sum(abs(input - i)*(abs(input-i)+1)/2)
    if(next_min < min_score) {
      min_score <- next_min
    }
  }
  return(min_score)
}

gold(input)