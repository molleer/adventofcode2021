values = File.read("input.txt").split

count = 0
for i in 1..(values.length())
    if values[i-1].to_i < values[i].to_i
        count += 1
    end
end
puts count.to_s

count = 0
for i in 3..(values.length())
    if values[i-3].to_i < values[i].to_i
        count += 1
    end
end
puts count.to_s
