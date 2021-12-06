input <- read.csv("./day6/input.txt", header = F)[1,] + 1
counts <- rep(0, 9)
for(i in 1:9) {
  counts[i] = sum(input == (i-1))
}

for(i in 1:257) {
  new_fishes = counts[1]
  for(k in 1:8) {
    counts[k] = counts[k+1]
  }
  counts[7] = counts[7] + new_fishes
  counts[9] = new_fishes
}
print(sum(counts), digits=13)