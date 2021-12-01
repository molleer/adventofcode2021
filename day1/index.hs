silver (x1:x2:[])
    | x1 < x2 = 1
    | otherwise = 0
silver (x1:x2:xs)
    | x1 < x2 = 1 + silver (x2:xs)
    | otherwise = silver (x2:xs)

main1 = do
    s <- readFile "input.txt"
    return $ silver $ map (\i -> read i:: Integer) $ lines s

gold (x1:x2:x3:x4:[])
    | x1 < x4 = 1
    | otherwise = 0
gold (x1:x2:x3:x4:xs)
    | x1 < x4 = 1 + gold (x2:x3:x4:xs)
    | otherwise = gold (x2:x3:x4:xs)

main2 = do
    s <- readFile "input.txt"
    return $ gold $ map (\i -> read i:: Integer) $ lines s
