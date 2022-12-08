{-# LANGUAGE OverloadedStrings #-}

module Day02
    (
      day02Step1
    , day02Step2
    ) where
import Data.List.Split (splitOn)
import Data.List ((\\))
import Data.Map (Map, (!))
import qualified Data.Map as Map

day02Step1 :: [String] -> Int
day02Step1 x = do
  sum $ map calculateScore x

moveWeight = Map.fromList [("X", 1), ("Y", 2), ("Z", 3)] :: Map String Int
winningMoves = Map.fromList [("A", "Z"), ("B", "X"), ("C", "Y")] :: Map String String
moveConverted = Map.fromList [("A", "X"), ("B", "Y"), ("C", "Z")] :: Map String String

calculateScore :: String -> Int
calculateScore s 
  | theirMove' == myMove = weight + 3
  | winner == myMove     = weight
  | otherwise            = weight + 6
  where 
    (theirMove:myMove:_) = splitOn " " s
    winner = winningMoves ! theirMove
    theirMove' = moveConverted ! theirMove
    weight = moveWeight ! myMove 

day02Step2 :: [String] -> Int
day02Step2 x =
  sum $ map calculateScore2 x

calculateScore2 :: String -> Int
calculateScore2 s = do
  let (theirMove:myMove:_) = splitOn " " s
  let winner = winningMoves ! theirMove
  let theirMove' = moveConverted ! theirMove
  case myMove of
    "Y" -> 3 + (moveWeight ! theirMove') -- it's a draw
    "X" -> moveWeight ! winner -- we'll have to loose
    _ -> 6 + moveWeight ! head (["X", "Y", "Z"] \\ [winner, theirMove']) -- we're winners!
