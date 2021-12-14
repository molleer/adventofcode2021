library("stringr")
input <- read.csv("./day14/input.txt", header = T)
polymer <- "KBKPHKHHNBCVCHPSPNHF"
inserts <- matrix("", length(input[,1]), 4)

for(i in 1:(length(input[,1]))) {
  row <- str_split(input[i,1], " -> ")[[1]]
  key_split <- str_split(row[1], "")[[1]]
  inserts[i,] <- c(row[1], paste(key_split[1], row[2], sep = ""), paste(row[2], key_split[2], sep = ""), row[2])
}

chars <- c()
for(i in inserts[,1]) {
  chars <- c(chars, str_split(i, "")[[1]])
}
chars <- unique(chars)

char_count <- rep(0, length(chars))
for(i in 1:length(chars)) {
  char_count[i] <- str_count(polymer, chars[i])
}

counts <- rep(0, length(inserts[,1]))
for(i in 2:str_length(polymer)) {
  index <- which(inserts[,1] == substr(polymer, i-1, i))
  if(identical(integer(0), index)) {
    index <- length(counts) + 1
    counts <- c(counts, 0)
    inserts[i,] <- rbind(inserts, c(substr(polymer, i-1, i), "", "", ""))
  }
  counts[index] <- counts[index] + 1
}

for(i in 1:40) {
  new_count <- rep(0, length(counts))
  for(k in 1:length(counts)) {
    char_index <- which(chars == inserts[k,4])
    char_count[char_index] <- char_count[char_index] + counts[k]
    
    dest <- which(inserts[,1] == inserts[k,2])
    if(!identical(integer(0), dest)) {
      new_count[dest] <- new_count[dest] + counts[k]
    } else if (inserts[k,2] != "") {
      new_count <- c(new_count, counts[k])
      inserts <- rbind(inserts, c(inserts[k, 2], "", "", ""))
    }
    dest <- which(inserts[,1] == inserts[k,3])
    if(!identical(integer(0), dest)) {
      new_count[dest] <- new_count[dest] + counts[k]
    } else if (inserts[k,3] != "") {
      new_count <- c(new_count, counts[k])
      inserts <- rbind(inserts, c(inserts[k, 3], "", "", ""))
    }
  }
  counts <- new_count
}

print(max(char_count) - min(char_count), digits = 10)