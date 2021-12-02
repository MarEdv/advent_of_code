{-# LANGUAGE OverloadedStrings #-}

module Day01
    ( 
      day01Step1
    , day01Step2
    ) where

day01Step1 :: [String] -> Int
day01Step1 x = do
  let z = map (\a -> read a :: Int) x
  countIncreasesInt z

countIncreasesInt :: [Int] -> Int
countIncreasesInt x = do
  let z = zip x (drop 1 x)
  let y = filter (uncurry (<)) z
  length y

day01Step2 :: [String] -> Int
day01Step2 q = do
  let x = map (\a -> read a :: Int) q
  let z = zip (drop 2 x) $ zip x (drop 1 x)
  let y = map (\(a, (b, c)) -> a + b + c) z
  countIncreasesInt y