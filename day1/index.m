file = fopen("input.txt");
inp = fscanf(file, "%d\n");
fclose(file);

count = 0;
for i = 2:length(inp) 
    if inp(i-1) < inp(i)
        count = count + 1;
    end
end
disp(count);

count = 0;
for i = 4:length(inp) 
    if inp(i-3) < inp(i)
        count = count + 1;
    end
end
disp(count);
