{-# LANGUAGE OverloadedStrings #-}

module Day06
    (
      day06Step1
    , day06Step2
    ) where
import Data.List.Split (splitOn)
import Data.List (group, sort)

day06Step1 :: [String] -> Int
day06Step1 x = do
  simulation x 80

simulation :: [String]  ->  Int -> Int
simulation x n = do
  let intList = map (\a -> read a :: Int) $ splitOn "," $ head x
  let grouped = group $ sort intList
  let lanternFishes = take 9 $ [0] ++ map length grouped ++ repeat 0
  sum $ updateLanternFishes lanternFishes n

updateLanternFishes :: [Int] -> Int -> [Int]
updateLanternFishes x 0 = x
updateLanternFishes (x0:x1:x2:x3:x4:x5:x6:x7:x8:xs) n = updateLanternFishes [x1,x2,x3,x4,x5,x6, x7 + x0, x8, x0] $ n - 1
updateLanternFishes x _ = []

day06Step2 :: [String] -> Int
day06Step2 x = do
  simulation x 256
