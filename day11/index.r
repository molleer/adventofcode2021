library("stringr")

size <- 10

input <- matrix(0, size, size)
map <- function(arr, f) {
  ans <- c()
  for(i in arr) {
    ans <- c(ans, f(i))
  }
  return(ans)
}

data <- read.csv("./day11/input.txt", header = F)
for(i in 1:size) {
  input[i,] <- strtoi(str_split(data[i,], "")[[1]])
}

spread <- function(co, input) {
  blinks <- 0
  input[co[1], co[2]] <- 0
  for(y in max(1, co[1]-1):min(size, co[1] + 1)) {
    for(x in max(1, co[2]-1):min(size, co[2] + 1)) {
      if(input[y, x] == 9) {
        blinks <- blinks + 1
        input[y, x] <- 0
        ans <- spread(c(y, x), input)
        blinks <- blinks + ans[[1]]
        input <- ans[[2]]
      } else if(input[y, x] != 0) {
        input[y, x] <- input[y, x] + 1
      }
    }
  }
  return(list(blinks, input))
}

blinks <- 0
count <- 0
while(T) {
  count <- count + 1
  input <- input + 1
  blink_coord <- which(input == 10, arr.ind = T)
  if(length(blink_coord) == 0) {
    next
  }
  for(i in 1:length(blink_coord[,1])) {
    blinks <- blinks + 1
    ans <- spread(blink_coord[i, ], input)
    blinks <- blinks + ans[[1]]
    input <- ans[[2]]
  }
  if(sum(input == 0) == 100) {
    break
  }
}
count