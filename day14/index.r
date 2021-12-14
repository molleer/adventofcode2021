library("stringr")
input <- read.csv("./day14/input.txt", header = T)
polymer <- "KBKPHKHHNBCVCHPSPNHF"
inserts <- matrix("", length(input[,1]), 2)

for(i in 1:(length(input[,1]))) {
  inserts[i,] <- str_split(input[i,1], " -> ")[[1]]
}
for(i in 1:40) {
  polymer_merge <- c(substr(polymer, 1,1))
  for(k in 2:(str_length(polymer))) {
    new_char <- inserts[which(inserts[,1] == substr(polymer, k-1, k)),2]
    if(!identical(character(0), new_char)) {
      polymer_merge <- c(polymer_merge, new_char)
    }
    polymer_merge <- c(polymer_merge, substr(polymer, k, k))
  }
  
  polymer <- paste(polymer_merge, collapse="")
  print(i)
}

pol <- str_split(polymer, "")[[1]]
chars <- unique(pol)

counts <- c()
for(i in chars) {
  counts <- c(counts, sum(pol == i))
}

max(counts) - min(counts)

