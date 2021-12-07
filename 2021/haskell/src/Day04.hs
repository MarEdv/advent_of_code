{-# LANGUAGE OverloadedStrings #-}

module Day04
    (
      day04Step1
    , day04Step2
    ) where
import Control.Monad (when)
import Data.Char ( digitToInt, isDigit )
import Data.List.Split
import Data.List (transpose)

type Cell = (Int, Bool)
type Board = [[Cell]]

day04Step1 :: [String] -> Int
day04Step1 x = do
  let numbers = map (\a -> read a :: Int) $ splitOn "," $ head x
  let boards = readBoards $ tail x
  let (number, boardWithBingo) = updateBoardsUntilBingo numbers boards
  let a = filter (not.snd) (concat boardWithBingo)
  number * sum (map fst a)

updateBoardsUntilBingo :: [Int] -> [Board] -> (Int, Board)
updateBoardsUntilBingo numbers boards = do
  let number = head numbers
  let updatedBoards = map (updateBoard number) boards
  let boardsWithBingo = filter isBingo updatedBoards
  if not (null boardsWithBingo) then
    (number, head boardsWithBingo)
  else
    updateBoardsUntilBingo (tail numbers) updatedBoards

isBingo :: Board -> Bool
isBingo b = do
  any (all snd) b || any (all snd) (transpose b)

updateBoard :: Int -> Board -> Board
updateBoard n b = do
  map (map (\(e, s) -> if e == n then (e, True) else (e, s))) b

readBoards :: [String] -> [Board]
readBoards x = do
  let boardLines = chunksOf 6 x
  map readBoard boardLines

readBoard :: [String] -> Board
readBoard x = do
  let boardLines = take 6 $ tail x
  map (map (\line -> (read line :: Int, False)) . words) boardLines

updateBoardsUntilBingo2 :: [Int] -> [Board] -> (Int, Board)
updateBoardsUntilBingo2 numbers boards = do
  let number = head numbers
  let updatedBoards = map (updateBoard number) boards
  let boardsWithBingo = filter isBingo updatedBoards
  let newBoards = filter (`notElem` boardsWithBingo) updatedBoards
  if length updatedBoards == 1 && length boardsWithBingo == 1 then
    (number, head boardsWithBingo)
  else
    updateBoardsUntilBingo2 (tail numbers) newBoards

day04Step2 :: [String] -> Int
day04Step2 x = do
  let numbers = map (\a -> read a :: Int) $ splitOn "," $ head x
  let boards = readBoards $ tail x
  let (number, boardWithBingo) = updateBoardsUntilBingo2 numbers boards
  let a = filter (not.snd) (concat boardWithBingo)
  number * sum (map fst a)

