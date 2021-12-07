{-# LANGUAGE OverloadedStrings #-}

module Day03
    (
      day03Step1
    , day03Step2
    ) where
import Data.Char ( digitToInt, isDigit )
import Data.List (sortBy, groupBy)

day03Step1 :: [String] -> Int
day03Step1 x = do
  let z = map (map digitToInt) x
  let a = day03Step1a z above
  let b = map (\a -> if a == 0 then 1 else 0) a
  let (y,_) = parseBinaryList a
  let (z,_) = parseBinaryList b
  z*y
  --[y,z]

parseBinaryList :: [Int] -> (Int, Int)
parseBinaryList = foldr (\i (acc, base) -> (i * base + acc, base * 2)) (0,1)

day03Step1a :: [[Int]] -> (Int -> Int -> Int) -> [Int]
day03Step1a z f = do
  let (count, xs) = foldl (\(count, xs) is -> (count + 1, zipWith (+) xs is)) (0, repeat 0) z
  let d = count `div` 2
  map (f d) xs

above :: Int -> Int -> Int
above a b = if a >= b then 1 else 0

below :: Int -> Int -> Int
below a b = if a < b then 1 else 0

day03Step2 :: [String] -> Int
day03Step2 x = do
  let [oxygenRating, co2Rating] = day03Step2a x
  let (o,_) = parseBinaryList oxygenRating
  let (co2,_) = parseBinaryList co2Rating
  o * co2

day03Step2a :: [String] -> [[Int]]
day03Step2a x = do
  let z = map (map digitToInt) x
  let oxygenRating = hej z (>) 0
  let co2Rating = hej z (<=) 0
  oxygenRating ++ co2Rating

hej :: [[Int]] -> (Int -> Int -> Bool) -> Int -> [[Int]]
hej [x] _ _ = [x]
hej x f n = do
  let a = sortBy (\a b -> compare (a !! n) (b !! n)) x
  let b = groupBy (\a b -> a !! n == b !! n) a
  let e = what b f
  hej e f (n+1)

what :: [[[Int]]] -> (Int -> Int -> Bool) -> [[Int]]
what b f = do
  if f (length (head b)) (length (last b))
    then head b
    else last b

day03 :: IO()
day03 = do
   content <- readFile "day03.txt"
   let linesOfFiles = lines content
   putStrLn "Day 3"
   putStrLn $ "\tStep 1: " ++ show (day03Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day03Step2 linesOfFiles)
