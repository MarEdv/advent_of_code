{-# LANGUAGE OverloadedStrings #-}

module Day07
    (
      day07Step1
    , day07Step2
    ) where
import Data.List ( sort )
import Data.List.Split (splitOn)

day07Step1 :: [String] -> Int
day07Step1 x = do
  let positions = map (\a -> read a :: Int) $ splitOn "," $ head x
  let sortedPositions = sort positions
  let g = map (sumFuelTo sortedPositions id) [head sortedPositions..last sortedPositions]
  minimum g

sumFuelTo :: [Int] -> (Int -> Int) -> Int -> Int
sumFuelTo x f n = do
  foldl (\a i -> a + f (abs i)) 0 (map (n -) x)

day07Step2 :: [String] -> Int
day07Step2 x = do
  let positions = map (\a -> read a :: Int) $ splitOn "," $ head x
  let sortedPositions = sort positions
  let g = map (sumFuelTo sortedPositions sumOfIntegersFromOneTo) [head sortedPositions..last sortedPositions]
  minimum g

sumOfIntegersFromOneTo :: Int -> Int
sumOfIntegersFromOneTo n = n * (n + 1) `div` 2
