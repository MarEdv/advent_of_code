{-# LANGUAGE OverloadedStrings #-}

module Day03
    (
      day03Step1
    , day03Step2
    , day03
    ) where
import Data.List (intersect)
import Data.Char (ord)
import Data.List.Split (chunksOf)

day03Step1 :: [String] -> Int
day03Step1 x = do
  sum $ map calculate x

calculate :: String -> Int
calculate x = priority (head a) where
  (comp1, comp2) = divideRucksack x
  a = comp1 `intersect` comp2

priority :: Char -> Int
priority x
  | ord x >= ord 'a' && ord x <= ord 'z' = ord x - 96
  | ord x >= ord 'A' && ord x <= ord 'Z' = ord x - 38
  | otherwise = ord x

divideRucksack :: String -> (String, String)
divideRucksack x = splitAt (length x `div` 2) x

day03Step2 :: [String] -> Int
day03Step2 x = do
  let cs = chunksOf 3 x
  sum $ map calculate2 cs

calculate2 :: [String] -> Int
calculate2 (a : b : c : xs) = priority (head s) where
  s = (a `intersect` b) `intersect` c

day03 :: IO()
day03 = do
   content <- readFile "day03.txt"
   let linesOfFiles = lines content
   putStrLn "Day 03"
   putStrLn $ "\tStep 1: " ++ show (day03Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day03Step2 linesOfFiles)
