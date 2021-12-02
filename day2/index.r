library("stringr")
input <- read.csv("./day2/input.txt", header=FALSE, sep=" ")

depth <- 0
h_pos <- 0

for(i in 1:length(input[,1])) {
  if(input[i, 1] == "up")  {
    depth <- depth - input[i, 2]
  }
  if(input[i, 1] == "down")  {
    depth <- depth + input[i, 2]
  }
  if(input[i, 1] == "forward")  {
    h_pos <- h_pos + input[i, 2]
  }
}
depth * h_pos

depth <- 0
h_pos <- 0
aim <- 0

for(i in 1:length(input[,1])) {
  if(input[i, 1] == "up")  {
    aim <- aim - input[i, 2]
  }
  if(input[i, 1] == "down")  {
    aim <- aim + input[i, 2]
  }
  if(input[i, 1] == "forward")  {
    h_pos <- h_pos + input[i, 2]
    depth <- depth + aim * input[i, 2]
  }
}
depth * h_pos
