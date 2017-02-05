module Lib
    (
        filterOdd
      , step1
      , step2
    ) where

import Data.List
import Data.Maybe

step1 :: [a] -> a
step1 (x:[]) = x
step1 xs = step1 newList where
  list = filterOdd xs
  newList
    | length xs `mod` 2 == 1 = tail list
    | otherwise = list

filterOdd :: [a] -> [a]
filterOdd xs = filterList isOdd xs

filterList :: ((Int, a) -> Bool) -> [a] -> [a]
filterList f xs = map (\x -> snd x) list where
  z = zip [1..] xs
  list = filter f z

isOdd :: (Int, a) -> Bool
isOdd (x,_) = x `mod` 2 == 1

step2 :: [a] -> a
step2 (x:[]) = x
step2 (x:y:[]) = x
step2 xs = step2 x where
  l = length xs
  (first, second) = splitAt (l `div` 2) xs
  selection = if odd l
              then [False, True, False]
              else [False, False, True]
  newSecond = map snd $ filter fst $ zip (cycle selection) second
  noHandled = (length second) - (length newSecond)
  noRemaining = length first + length newSecond
  x = take noRemaining $ drop noHandled $ cycle (first ++ newSecond)
