file = open("./input.txt", "r")
def f(a):
    return int(a)
input = list(map(f, file.read().split("\n")))
file.close()

count = 0
for i in range(1, len(input)):
    if input[i-1] < input[i]:
        count = count + 1
print(count)

count = 0
for i in range(3, len(input)):
    if input[i-3] < input[i]:
        count = count + 1
print(count)