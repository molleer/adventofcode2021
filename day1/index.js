const fs = require("fs")

fs.readFile("./input.txt", (err, data) => {
    data = String(data).split("\n").map(e => Number(e))
    let count = 0;
    for(var i=1; i < data.length; i++) {
        if(data[i-1] < data[i]) count++;
    }
    console.log(count)

    count = 0;
    for(var i=3; i < data.length; i++) {
        if(data[i-3] < data[i]) count++;
    }
    console.log(count)    
})
