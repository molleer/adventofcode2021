library("stringr")
input <- read.csv("./day13/input.txt", header = T, sep=",")
coord_rows <- which(!is.na(input[,2]))
inst_rows <- which(is.na(input[,2]))

map <- function(arr, f) {
  ans <- list()
  for(i in arr) {
    ans <- append(ans, list(f(i)))
  }
  return(ans)
}

coords_str <- input[min(coord_rows):max(coord_rows),]
coords <- matrix(0, length(coords_str[,1]), 2)
for(i in 1:length(coords_str[,1])) {
  coords[i,1] <- strtoi(coords_str[i,1])
  coords[i,2] <- strtoi(coords_str[i,2])
}
coords
  
instrs <- map(input[min(inst_rows):max(inst_rows),1], function(inst) {
  split <- str_split(inst, "=")
  ans <- c("y", split[[1]][2])
  if(str_count(inst, "x")) {
    ans[1] <- "x"
  }
  return(ans)
})

foldX <- function(x, coord) {
  if(coord[1] > x) {
    coord[1] <- 2*x - coord[1]
  }
  return(coord)
}

foldY <- function(y, coord) {
  if(coord[2] > y) {
    coord[2] <- 2*y - coord[2]
  }
  return(coord)
}

for(inst in instrs) {
  line <- strtoi(inst[2])
  if(inst[1] == "x") {
    for(k in 1:length(coords[,1])) {
      coords[k,] <- foldX(line, coords[k,])
    }
  } else {
    for(k in 1:length(coords[,1])) {
      coords[k,] <- foldY(line, coords[k,])
    }
  }
}

coords <- unique(coords)
plot(coords[,1], -coords[,2], ylim = c(-10, 0))