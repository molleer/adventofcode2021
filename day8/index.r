library("stringr")
input <- read.csv("./day8/input.txt", header = F, sep = " ")

silver <- function(input) {
  count <- 0
  for(i in 1:length(input[,1])) {
    for(k in 12:15) {
      n <- nchar(input[i, k])
      if(n == 2 || n == 4 || n == 3 || n == 7) {
        count <- count + 1
      }
    }
  }
  return(count)
}

sort_string <- function(str) {paste(sort(str_split(str, "")[[1]]), collapse = "")}
sort_letters <- function(arr) {paste(sort(arr), collapse = "")}
subtr <- function(this, that) {
  res <- c()
  for(i in this) {
    if(!any(that == i)) {
      res <- c(res, i)
    }
  }
  return(res)
}
map <- function(arr, f) {
  ans <- c()
  for(i in arr) {
    ans <- c(ans, f(i))
  }
  return(ans)
}
contains <- function(this, that) {
  # if this contains that
  all(map(that, function(e) {any(this == e)}))
}


# 1 seg -> 
# 2 seg -> 1
# 3 seg -> 7
# 4 seg -> 4
# 5 seg -> 2 3 5
  # contains 1 -> 3
  # contains 4 - 1 -> 5
  # else -> 2
# 6 seg -> 0 6 9
  # !contains 1 -> 6
  # contains 4 - 1 -> 9
  # else -> 0
# 7 seg -> 8

get_order <- function(line) {
  nums <- map(line, function(word) {str_split(word, "")[1]})
  digits <- rep(list(), 10)
  for(i in nums) {
    len <- length(i)
    if(len == 2) {
      digits[2] <- list(i)
    } else if (len == 3) {
      digits[8] <- list(i)
    } else if(len == 4) {
      digits[5] <- list(i)
    } else if(len == 7) {
      digits[9] <- list(i)
    }
  }
  bdSeg <- subtr(digits[[5]], digits[[2]])
  for(i in nums) {
    len <- length(i)
    if(len == 5) {
      if(contains(i, digits[[2]])) {
        digits[4] <- list(i)
      } else if(contains(i, bdSeg)) {
        digits[6] <- list(i)
      } else {
        digits[3] <- list(i)
      }
    } else if(len == 6) {
      if(!any(contains(i, digits[[2]]))) {
        digits[7] <- list(i)
      } else if(contains(i, bdSeg)) {
        digits[10] <- list(i)
      } else {
        digits[1] <- list(i)
      }
    }
  }
  return(map(digits, sort_letters))
}

gold <- function(input) {
  sum <- 0
  for(i in 1:length(input[,1])) {
    num <- 0
    digits <- get_order(input[i, 1:10])
    for(k in 12:15) {
      num <- num + 10^(15-k) * (which(digits == sort_string(input[i, k])) - 1)
    }
    sum <- sum + num
    print(num)
  }
  return(sum)
}
# get_order(str_split("afg daecgf aefbgdc fbge fg dabfg efabgd cbadge abcfd gbaed", " ")[[1]])
gold(input)
