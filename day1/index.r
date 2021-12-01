input <- read.csv("./day1/input.txt", header=FALSE)[,1]

count <- 0
for(i in 2:length(input)) {
  if(input[i-1] < input[i]) {
    count <- count + 1
  }
}
count

count <- 0
for(i in 4:length(input)) {
  if(input[i-3] < input[i]) {
    count <- count + 1
  }
}
count