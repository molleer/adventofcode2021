
string[] input = System.IO.File.ReadAllLines("./input.txt");
int[] nums = new int[input.Count()];
for(int i = 0; i < input.Count(); i++) {
    nums[i] = System.Int32.Parse(input[i]);
}

int count = 0;
for(int i = 1; i < nums.Count(); i++) {
    if(nums[i-1] < nums[i]) {
        count++;
    }
}
Console.Out.WriteLine(count);

count = 0;
for(int i = 3; i < nums.Count(); i++) {
    if(nums[i-3] < nums[i]) {
        count++;
    }
}
Console.Out.WriteLine(count);
