library("stringr")
input <- read.csv("./day9/input.txt", header=FALSE, colClasses = "character")
input <- str_split(input[[1]], "")
map <- function(arr, f) {
  ans <- c()
  for(i in arr) {
    ans <- c(ans, f(i))
  }
  return(ans)
}
input <- map(input, function(e) {list(map(e, as.numeric))})

check_neighbours <- function(x, y, input) {
  ans <- 0
  for(row in max(y-1, 1):min(y+1, length(input))) {
    ans <- ans + sum(input[[row]][max(x-1, 1):min(x+1, length(input[[row]]))] <= input[[y]][x])
  }
  return(ans)
}

silver <- function(input) {
  risk <- 0
  for(y in 1:length(input)) {
    for(x in 1:length(input[[y]])) {
      if(check_neighbours(x,y,input) <= 1) {
        risk <- risk + input[[y]][x] + 1
      }
    }
  }
  return(risk)
}

new_input <- matrix(T, 100, 100)
for(row in 1:100) {
  new_input[row,] <- input[[row]] != 9
}


search_area <- matrix(F, 100, 100)
basin_size <- function(row, col, input, searched) {
  size <- 0
  if(row < 100 && input[row + 1, col] && !searched[row + 1, col]) {
    searched[row + 1, col] <- T
    ans <- basin_size(row + 1, col, input, searched)
    size <- 1 + ans[[1]]
    searched <- ans[[2]]
  }
  if(row > 1 && input[row - 1, col] && !searched[row - 1, col]) {
    searched[row - 1, col] <- T
    ans <- basin_size(row - 1, col, input, searched)
    size <- size + 1 + ans[[1]]
    searched <- ans[[2]]
  }
  if(col < 100 && input[row, col + 1] && !searched[row, col + 1]) {
    searched[row, col + 1] <- T
    ans <- basin_size(row, col + 1, input, searched)
    size <- size + 1 + ans[[1]]
    searched <- ans[[2]]
  }
  if(col > 1 && input[row, col - 1] && !searched[row, col - 1]) {
    searched[row, col - 1] <- T
    ans <- basin_size(row, col - 1, input, searched)
    size <- size + 1 + ans[[1]]
    searched <- ans[[2]]
  }
  return(list(size, searched))
}

sizes <- c()
for(row in 1:100) {
  for(col in 1:100) {
    if(new_input[row, col] && !search_area[row, col]){
      search_area[row, col] <- T
      ans <- basin_size(row, col, new_input, search_area)
      search_area <- ans[[2]]
      sizes <- c(sizes, ans[[1]] + 1) 
    }
  }
}

sizes <- sort(sizes, decreasing = T)
sizes[1]*sizes[2]*sizes[3]