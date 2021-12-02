{-# LANGUAGE OverloadedStrings #-}

module Day02
    ( 
      day02Step1
    , day02Step2
    ) where
import Control.Monad (when)

day02Step1 :: [String] -> Int
day02Step1 x = do
  let operations = map getOperation x
  let (x, y) = foldl (\(a1,a2) (b1, b2)-> (a1+b1,a2+b2)) (0,0) operations
  x*y

day02Step2 :: [String] -> Int
day02Step2 x = do
  let operations = map getOperation x
  let (x, y, _) = foldl (\(x1, y1, aim1) (x2, aim2) -> 
        (x1 + x2, y1 + aim1 * x2, aim1 + aim2)) 
        (0,0,0) 
        operations
  x*y

getOperation :: String -> (Int, Int)
getOperation s = delta where
  (operation:numString:xs) = words s
  number = read numString :: Int
  delta = case operation of
    "forward" -> (number, 0)
    "up" -> (0, negate number)
    "down" -> (0, number)
    _ -> (0,0)
    