library("stringr")
input <- read.csv("./day12/input1.txt", sep = "-", header = F)
nodes <- unique(c(input[,1], input[,2]))
large_caves <- str_count(nodes, "[A-Z]+")
connections <- matrix(0, length(nodes), length(nodes))

for(i in 1:length(input[,1])) {
  from <- which(nodes == input[i,1])
  to <- which(nodes == input[i,2])
  connections[from, to] <- 1
  connections[to, from] <- 1
}

dec <- function(arr) {
  for(i in 1:length(arr)) {
    if(arr[i] > 0) {
      arr[i] <- arr[i] - 1
    }
  }
  return(arr)
}

decSmallCaves <- function(mat, large_caves) {
  for(i in 1:length(large_caves)) {
    if(large_caves[i] == 0 && nodes[i] != "end") {
      mat[,i] <- dec(mat[,i])
    }
  }
  return(mat)
}

explore <- function(node, nodes, large_caves, connections) {
  if(nodes[node] == "end") {
    return(list(c(node)))
  }
  if(all(connections[node,] == 0)) {
    return(list())
  }
  paths <- list()
  for(n in which(connections[node,] > 0)) {
    new_conn <- connections
    if(large_caves[n] == 0) {
      new_conn[,n] <- dec(new_conn[,n])
    }
    for(p in explore(n, nodes, large_caves, new_conn)) {
      paths <- append(paths, list(c(node, p)))
    }
  }
  return(paths)
}

start <- which(nodes == "start")
connections[,start] <- 0



conns <- list()
for(to in 1:length(connections[1,])) {
  new_conn <- connections
  for(from in 1:length(connections[,1])) {
    if(large_caves[to] == 0 && connections[from, to] > 0 && nodes[to] != "start" && nodes[to] != "end") {
      new_conn[from, to] <- 2
    }
  }
  if(any(new_conn != connections)) {
    conns <- append(conns, list(new_conn))
  }
}

paths <- list()
count <- 0

for(conn in conns) {
  count <- count + 1
  print(count)
  paths <- unique(append(paths, explore(start, nodes, large_caves, conn)))
}
# for(p in paths) {
#   names <- "start"
#   for(n in 2:length(p)) {
#     names <- paste(names, nodes[p[n]], sep=",")
#   }
#   print(names)
# }

length(paths)