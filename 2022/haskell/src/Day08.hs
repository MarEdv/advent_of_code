{-# LANGUAGE OverloadedStrings #-}

module Day08
    (
      day08Step1
    , day08Step2
    , day08
    ) where

import qualified Data.Array as A
import Debug.Trace (trace)
import Data.List (foldl')

day08Step1 :: [String] -> Int
day08Step1 x = do
  let array = mkArray x
  length $ filter id (calculate isTreeVisible array)

day08Step2 :: [String] -> Int
day08Step2 x = do
  let array = mkArray x
  maximum (calculate calculateScenicScore array)

type MyArray = A.Array (Int, Int) Char

mkArray :: [String] -> MyArray
mkArray input = A.listArray ((0,0),(x_max,y_max)) (concat input) where
  x_max = length (head input) - 1
  y_max = length input - 1

calculate :: (MyArray -> ((Int, Int), Char)-> a) -> MyArray -> [a]
calculate f array = map (f array) (A.assocs array)

isTreeVisible :: MyArray -> ((Int, Int), Char)-> Bool
isTreeVisible array element = case element of
  (position, char) -> or c where
    idx = mkIndices position (A.bounds array)
    vals = map (map (array A.!)) idx
    m = map (\x -> maximum (' ' : x)) vals
    currentTreeHeight = array A.! position
    c = map (currentTreeHeight >) m

calculateScenicScore :: MyArray -> ((Int, Int), Char)-> Int
calculateScenicScore array element = case element of
  (position, char) -> foldl' (*) 1 viewingDistances where
    idx = mkIndices position (A.bounds array)
    vals = map (map (array A.!)) idx
    currentTreeHeight = array A.! position
    viewingDistances = map (calcViewingDistance currentTreeHeight) vals

calcViewingDistance currentTreeHeight trees = min (length viewingDistance + 1) (length trees) where
  viewingDistance = takeWhile (< currentTreeHeight) trees

mkIndices (x1,y1) ((x_min, y_min), (x_max, y_max)) = [
        reverse [(x,y1) | x <- [x_min..x1-1], x >= x_min],
        [(x,y1) | x <- [x1+1..x_max], x <= x_max],
        reverse [(x1,y) | y <- [y_min..y1-1], y >= y_min],
        [(x1,y) | y <- [y1+1..y_max], y <= y_max]
      ]

day08 :: IO()
day08 = do
   content <- readFile "day08.txt"
   let linesOfFiles = lines content
   putStrLn "Day 08"
   putStrLn $ "\tStep 1: " ++ show (day08Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day08Step2 linesOfFiles)
