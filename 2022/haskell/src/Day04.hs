{-# LANGUAGE OverloadedStrings #-}

module Day04
    (
      day04Step1
    , day04Step2
    , day04
    , overlaps
    ) where
import Data.List.Split
import Text.ParserCombinators.ReadP

day04Step1 :: [String] -> Int
day04Step1 x = do
  length $ filter id (map (convert overlaps) x)

overlaps :: (Ord a) => (a, a) -> (a, a) -> Bool
overlaps (s1, e1) (s2, e2) = s1<=s2 && e1>=e2 || s1>=s2 && e1<=e2

overlaps2 :: (Ord a) => (a, a) -> (a, a) -> Bool
overlaps2 p1@(s1, e1) p2@(s2, e2) = isWithin s1 p2
  || isWithin e1 p2
  || isWithin s2 p1
  || isWithin e2 p1

isWithin :: (Ord a) => a -> (a, a) -> Bool
isWithin x (s, e) = x>=s && x<=e

day04Step2 :: [String] -> Int
day04Step2 x = do
  length $ filter id (map (convert overlaps2) x)

convert :: ((Int, Int) -> (Int, Int) -> Bool) -> String -> Bool
convert overlapFn interval = overlapFn intPair1 intPair2 where
  strIntervalPair = splitOn "," interval
  intervalPairs = map (splitOn "-") strIntervalPair
  (intPair1 : intPair2 : xs) = map (\(a : b : xs) -> (read a :: Int, read b :: Int)) intervalPairs

day04 :: IO()
day04 = do
   content <- readFile "day04.txt"
   let linesOfFiles = lines content
   putStrLn "Day 04"
   putStrLn $ "\tStep 1: " ++ show (day04Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day04Step2 linesOfFiles)
