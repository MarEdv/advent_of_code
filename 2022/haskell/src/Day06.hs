{-# LANGUAGE OverloadedStrings #-}

module Day06
    (
      day06Step1
    , day06Step2
    , day06
    ) where
import Data.List (nub)

day06Step1 :: [String] -> Int
day06Step1 x = do
  let s = head x
  findFrame 4 s 4

day06Step2 :: [String] -> Int
day06Step2 x = do
  let s = head x
  findFrame 14 s 14

findFrame :: Int -> String -> Int -> Int
findFrame c s n
  | length (nub (take c s)) == c = n
  | otherwise = findFrame c (tail s) n+1

day06 :: IO()
day06 = do
   content <- readFile "day06.txt"
   let linesOfFiles = lines content
   putStrLn "Day 06"
   putStrLn $ "\tStep 1: " ++ show (day06Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day06Step2 linesOfFiles)
