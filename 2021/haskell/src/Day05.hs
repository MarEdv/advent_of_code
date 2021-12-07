{-# LANGUAGE OverloadedStrings #-}

module Day05
    (
      day05Step1
    , day05Step2
    ) where
import Data.List.Split (splitOn)
import Data.List (sort, group, nub)

parseTuple :: String -> (Int, Int)
parseTuple x = do
  let (a:b:cs) = map (\q -> read q :: Int) (splitOn "," x)
  (a, b)

parseTuples :: [String] -> [((Int, Int), (Int, Int))]
parseTuples x = do
  let parsedLines = map (splitOn " -> ") x
  let parsedTuplesInList = map (\(a:b:cs) -> sort [parseTuple a, parseTuple b]) parsedLines
  map (\(a:b:cs) -> (a,b)) parsedTuplesInList

countOverlappingLines :: [(Int, Int)] -> Int
countOverlappingLines points = do
  let grouped = group $ sort points
  let groupedFiltered = filter (\a -> length a >= 2) grouped
  length $ nub $ concat groupedFiltered

day05Step1 :: [String] -> Int
day05Step1 x = do
  let parsedTuples = parseTuples x
  let filteredTuples = filter (\((i1,j1),(i2, j2)) -> i1 == i2 || j1 == j2) parsedTuples
  let points = concatMap (\((i1,j1),(i2,j2)) -> [(a,b) | a <- [i1..i2], b <- [j1..j2]]) filteredTuples
  countOverlappingLines points

day05Step2 :: [String] -> Int
day05Step2 x = do
  let parsedTuples = parseTuples x
  let points = concatMap (\((i1,j1),(i2,j2)) -> 
          [(a,b) | 
          a <- [min i1 i2..max i1 i2], 
          b <- [min j1 j2..max j1 j2], 
          i1 == i2 || j1 == j2 || -- if horisontal or vertical line
          j1 <= j2 && (a-b == i1-j1) || -- if diagonal line and increasing
          j1 >= j2 && (a+b == i1+j1)]) -- if diagonal line and decreasing
          parsedTuples
  countOverlappingLines points

