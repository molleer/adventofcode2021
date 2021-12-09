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

risk <- 0
for(y in 1:length(input)) {
  for(x in 1:length(input[[y]])) {
    if(check_neighbours(x,y,input) <= 1) {
      risk <- risk + input[[y]][x] + 1
    }
  }
}
risk
# map(input, function(e) {str_split(e, "")})
