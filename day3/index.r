library("stringr")
input <- read.csv("./day3/input.txt", header=FALSE, colClasses = "character")
input <- str_split(input[[1]], "")

aver <- function(i, inp) {
  sum <- 0
  for(line in inp) {
    sum <- sum + strtoi(line[i])
  }
  return(sum/length(inp))
}

gamma <- 0
epsilon <- 0
len <- 12

for(i in 1:len) {
  if(aver(i, input) > 0.5) {
    gamma <- gamma + 2^(len - i)
  }
  else {
    epsilon <- epsilon + 2^(len - i)
  }
}

gamma*epsilon

search <- function(inp, criteria, i) {
  len <- 0
  ans <- list()
  for(line in inp) {
    if(line[i] == criteria) {
      len <- len + 1
      ans[[len]] <- line
    }
  }
  return(ans)
}

parseBi <- function(numArr) {
  ans <- 0
  len <- length(numArr)
  for(i in 1:len) {
    if(numArr[i] == "1") {
      ans <- ans + 2^(len-i)
    }
  }
  return(ans)
}

input1 <- input
i <- 1
while(length(input1) > 1) {
  if(aver(i, input1) >= 0.5) {
    input1 <- search(input1, "1", i)
  } else {
    input1 <- search(input1, "0", i)
  }
    
  i <- i + 1
}

input2 <- input
i <- 1
while(length(input2) > 1) {
  if(aver(i, input2) >= 0.5) {
    input2 <- search(input2, "0", i)
  } else {
    input2 <- search(input2, "1", i)
  }
  
  i <- i + 1
}

parseBi(input1[[1]])*parseBi(input2[[1]])