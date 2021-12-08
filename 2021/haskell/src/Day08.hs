{-# LANGUAGE OverloadedStrings #-}

module Day08
    (
      day08Step1
    , day08Step2
    ) where
import Data.List.Split
import Data.List (groupBy, sort, (\\))
import Data.Map (fromList, Map, empty)

day08Step1 :: [String] -> Int
day08Step1 x = do
  let wordsed = map words x
  let grouped = map (groupBy (\a b -> b /= "|")) wordsed
  let secondPart = map last grouped
  let mapToLength = map (map length) secondPart
  let filtered = map (filter (\a -> a `elem` [2,3,4,7])) mapToLength
  length $ concat filtered

type Signal = (String, Int)

day08Step2 :: [String] -> Int
day08Step2 x = do
  let outputValues = map resolveOutputValues x
  sum $ map toInt outputValues

resolveOutputValues :: String -> [Int]
resolveOutputValues x = do
  let wordsed = words x
  let grouped = groupBy (\a b -> b /= "|") wordsed
  let (signalPattern, output) = (\(a:b:xs) -> (a, b)) grouped
  let mappings = getMappings signalPattern
  map (\a -> fst $ head (filter (\(_, b) -> sort b == sort a) mappings)) (filter (/= "|") output)


getMappings :: [String] -> [(Int, String)]
getMappings x = do
  let one = (1, head (filter (\a -> length a == 2) x))
  let four = (4, head (filter (\a -> length a == 4) x))
  let seven = (7, head (filter (\a -> length a == 3) x))
  let eight = (8, head (filter (\a -> length a == 7) x))
  let zeroSixNine = resolveZeroSixNine (filter (\a -> length a == 6) x) one four
  let six = head $ filter (\(a,_) -> a == 6) zeroSixNine
  let twoThreeFive = resolveTwoThreeFive (filter (\a -> length a == 5) x) one six
  [one, four, seven, eight] ++ zeroSixNine ++ twoThreeFive

resolveZeroSixNine :: [String] -> (Int, String) -> (Int, String) -> [(Int, String)]
resolveZeroSixNine x one four = do
  let nine = head $ filter (\a -> length (a \\ snd four) == 2) x
  let zeroSix = x \\ [nine]
  let zero = head $ filter (\a -> length (a \\ snd one) == 4) zeroSix
  [(0, zero), (6, head $ zeroSix \\ [zero]), (9, nine)]

resolveTwoThreeFive :: [String] -> (Int, String) -> (Int, String) -> [(Int, String)]
resolveTwoThreeFive x one six = do
  let three = head $ filter (\a -> null (snd one \\ a)) x
  let twoFive = x \\ [three]
  let two = head $ filter (\a -> length (a \\ snd six) == 1) twoFive
  [(3, three), (5, head $ twoFive \\ [two]), (2, two)]

toInt :: [Int] -> Int
toInt x = acc where
  (acc, _) = foldr (\i (acc, base) -> (i * base + acc, base * 10)) (0,1) x

day08 :: IO()
day08 = do
   content <- readFile "day08.txt"
   let linesOfFiles = lines content
   putStrLn "Day 8"
   putStrLn $ "\tStep 1: " ++ show (day08Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day08Step2 linesOfFiles)
