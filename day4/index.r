input <- read.csv2("./day4/input.txt", header=F, sep="")
order <- c(57,9,8,30,40,62,24,70,54,73,12,3,71,95,58,88,23,81,53,80,22,45,98,37,18,72,14,20,66,0,19,31,82,34,55,29,27,96,48,28,87,83,36,26,63,21,5,46,33,86,32,56,6,38,52,16,41,74,99,77,13,35,65,4,78,91,90,43,1,2,64,60,94,85,61,84,42,76,68,10,49,89,11,17,79,69,39,50,25,51,47,93,44,92,59,75,7,97,67,15)
picks <- matrix(0, nrow = length(input[,1]), ncol = length(input[1,]))
print(input)
checkBoard <- function(picked, x, y) {
  if(any(sum(picked[x,]) == 5)) {
    return(T)
  }
  if(sum(picked[,y]) == 5) {
    return(T)
  }
  return(F)
}

silver <- function() {
  for(n in order) {
    k <- which(input == n, arr.ind = T)
    for(i in 1:length(k[,1])) {
      picks[k[i,1], k[i, 2]] <- 1
      mc <- c(k[i,1] - ((k[i,1] - 1) %% 5), k[i,2])
      if(checkBoard(picks[mc[1]:(mc[1]+4), 1:5], k[i,1] - mc[1] + 1, k[i,2])) {
        p <- picks[mc[1]:(mc[1]+4), 1:5] == 0
        m <- input[mc[1]:(mc[1]+4), 1:5]
        return(sum(p*m)*n)
      }
    }
  }
}

gold <- function() {
  size <- length(input[,1])/5
  wins <- 0
  winners <- c()
  for(n in order) {
    k <- which(input == n, arr.ind = T)
    for(i in 1:length(k[,1])) {
      mc <- c(k[i,1] - ((k[i,1] - 1) %% 5), k[i,2])
      if(any(winners == mc[1])) {
        next
      }
      picks[k[i,1], k[i, 2]] <- 1
      if(checkBoard(picks[mc[1]:(mc[1]+4), 1:5], k[i,1] - mc[1] + 1, k[i,2])) {
        wins <- wins + 1
        winners <- append(mc[1], winners)
        if(wins == size) {
          p <- picks[mc[1]:(mc[1]+4), 1:5] == 0
          m <- input[mc[1]:(mc[1]+4), 1:5]
          print(p)
          print(m)
          return(sum(p*m)*n)
        }
      }
    }
  }
}
gold()