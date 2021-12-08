library("stringr")
input <- read.csv("./day8/input.txt", header = F, sep = " ")

silver <- function(input) {
  count <- 0
  for(i in 1:length(input[,1])) {
    for(k in 12:15) {
      n <- nchar(input[i, k])
      if(n == 2 || n == 4 || n == 3 || n == 7) {
        count <- count + 1
      }
    }
  }
  return(count)
}

sort_letters <- function(str) {paste(sort(str_split(str, "")[[1]]), collapse = "")}

get_order <- function(line) {
  
}

gold <- function() {
  
  sum <- 0
  for(i in 1:length(input[,1])) {
    num <- 0
    digits <- get_order(input[i, 1:10])
    for(k in 12:15) {
      num <- 10^(16-i) * (which(digits == sort_letters(input[i, k])) - 1)
    }
    print(num)
  }
  return(sum)
}

gold()