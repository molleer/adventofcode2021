package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	input, _ := ioutil.ReadFile("./input.txt")
	values := strings.Split(string(input), "\n")
	ints := []int{}
	for _, i := range values {
		v, _ := strconv.Atoi(i)
		ints = append(ints, v)
	}

	count := 0
	for i := 1; i < len(ints); i++ {
		if ints[i-1] < ints[i] {
			count++
		}
	}
	fmt.Println(count)

	count = 0
	for i := 3; i < len(ints); i++ {
		if ints[i-3] < ints[i] {
			count++
		}
	}
	fmt.Println(count)
}
