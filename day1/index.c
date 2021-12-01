#include <stdio.h>
#include <stdlib.h>

int strToI(char* str) {
    int ans = str[0] - 48;
    for(int i = 1; str[i]; i++) {
        ans *= 10;
        ans += str[i] - 48;
    }
    return ans;
}

int main() {
    FILE* fp = fopen("./input.txt", "r");
    char line[20];
    int nums[2000];

    for(int i = 0; i < 2000; i++) {
        fgets(line, 20, fp);
        nums[i] = strToI(line);
    }
    fclose(fp);

    int count = 0;
    for(int i = 1; i < 2000; i++)  {
        if(nums[i-1] < nums[i]) count++;
    }
    printf("%d\n", count);

    count = 0;
    for(int i = 3; i < 2000; i++)  {
        if(nums[i-3] < nums[i]) count++;
    }
    printf("%d\n", count);
    return 0;
}