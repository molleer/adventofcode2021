import fs from "fs";

fs.readFile("./day1/input.txt", (err, data: Buffer) => {
  let input: number[] = String(data)
    .split("\n")
    .map((e) => Number(e));
  let count: number = 0;
  for (var i: number = 1; i < input.length; i++) {
    if (input[i - 1] < input[i]) count++;
  }
  console.log(count);

  count = 0;
  for (var i = 3; i < input.length; i++) {
    if (input[i - 3] < input[i]) count++;
  }
  console.log(count);
});
