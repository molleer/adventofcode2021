DROP TABLE Inputs;

CREATE TABLE Inputs (
    id SERIAL NOT NULL,
    value INT NOT NULL
);

COPY Inputs (value)
FROM '/aoc/day1/input.txt'
WITH (FORMAT CSV);

SELECT COUNT(*) FROM Inputs AS i1, Inputs AS i2 WHERE i1.id+1 = i2.id AND i1.value < i2.value;
SELECT COUNT(*) FROM Inputs AS i1, Inputs AS i2 WHERE i1.id+3 = i2.id AND i1.value < i2.value;
