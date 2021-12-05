input <- read.csv("./day5/input.txt", header = F) + 1
field <-matrix(0, nrow = max(input[,2], input[,4]), ncol = max(input[,1], input[,3]))

for(i in 1:length(input[,1])) {
  if(input[i,1] == input[i,3] || input[i,2] == input[i,4]) {
    x <- min(input[i,1], input[i,3]):max(input[i,1], input[i,3])
    y <- min(input[i,2], input[i,4]):max(input[i,2], input[i,4])
    field[y, x] <- field[y, x] + 1     
  } else {
    # This else is only for part 2
    x <- min(input[i,1], input[i,3]):max(input[i,1], input[i,3])
    y <- min(input[i,2], input[i,4]):max(input[i,2], input[i,4])
    d <- diag(1, nrow=length(x), ncol=length(y))
    if((input[i,2] - input[i,4])/(input[i,1] - input[i,3]) < 0) {
      d <- d[,c(length(y):1), drop=F]
    }
    
    field[y, x] <- field[y, x] + d 
  }
}

sum(field >= 2)