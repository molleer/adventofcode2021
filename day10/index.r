library("stringr")

map <- function(arr, f) {
  ans <- c()
  for(i in arr) {
    ans <- c(ans, f(i))
  }
  return(ans)
}

input <- map(read.csv("./day10/input.txt", header=F), function(e){str_split(e, "")})

silver <- function(input) {
  score <- 0
  stack <- c()
  
  for(line in input) {
    for(char in line) {
      top <- tail(stack, 1) 
      if(char == ")" && top != "(") {
        score <- score + 3
        break
      } else if(char == "]" && top != "[") {
        score <- score + 57
        break
      } else if(char == "}" && top != "{") {
        score <- score + 1197
        break
      } else if(char == ">" && top != "<") {
        score <- score + 25137
        break
      } else if (any(char == c("(", "[", "{", "<"))) {
        stack <- c(stack, char)
      } else {
        stack <- stack[-length(stack)]
      }
    }
  }
  return(score)
}

# silver(input)

get_score <- function(compl) {
  score <- 0
  for(i in compl) {
    score <- score * 5 + which(c(")", "]", "}", ">") == i)
  }
  return(score)
}

get_completion <- function(stack) {
  compl <- c()
  for(i in stack) {
    compl <- c(c(")", "]", "}", ">")[which(c("(", "[", "{", "<") == i)], compl)
  }
  return(compl)
}

stack <- c()
scores <- c()
for(line in input) {
  stack <- c()
  breaks <- F
  for(char in line) {
    top <- tail(stack, 1) 
    if(char == ")" && top != "(") {
      breaks <- T
      break
    } else if(char == "]" && top != "[") {
      breaks <- T
      break
    } else if(char == "}" && top != "{") {
      breaks <- T
      break
    } else if(char == ">" && top != "<") {
      breaks <- T
      break
    } else if (any(char == c("(", "[", "{", "<"))) {
      stack <- c(stack, char)
    } else {
      stack <- stack[-length(stack)]
    }
  }
  if(!breaks) {
    scores <- c(scores, get_score(get_completion(stack)))
  }
}
median(scores)