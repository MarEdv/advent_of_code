module Lib
    ( CellType (..)
    , Point
    , nextSteps
    , cellType
    , findAllPos
    , findTheGoal
    , WorkItem (..)
    ) where

import Numeric (showIntAtBase)
import Data.Char (intToDigit)
import Data.List

data CellType = Wall
  | Space
  deriving (Show, Eq)

type Point = (Int, Int)

data WorkItem = WorkItem {
      point :: Point
    , depth :: Int
    }

cellType :: Int -> Int -> Int -> CellType
cellType x y nr = cell where
  n = x*x + 3*x + 2*x*y + y + y*y + nr
  bits = countBits n
  cell = case (even bits) of
    True -> Space
    False -> Wall

countBits :: Int -> Int
countBits n = len where
  string = toBits n
  ones = filter (\x -> x == '1') string
  len = length ones

toBits :: Int -> String
toBits n = showIntAtBase 2 intToDigit n ""

nextSteps :: Int -> Int -> Int -> [(Int, Int)]
nextSteps x y nr = steps where
  possibleSteps =
    [ (x-1, y)
    , (x+1, y)
    , (x, y-1)
    , (x, y+1)
    ]
  isPositivePos = (\a -> (fst a) * (snd a) >= 0)
  ss = filter isPositivePos possibleSteps
  sss = map (\r -> (r, (cellType (fst r) (snd r) nr))) ss
  ssss = filter (\g -> (snd g) == Space) sss
  steps = map (\h -> fst h) ssss

{-
  Part 1
------------------
  Performs a breadth-first search to find the shortest path from the starting
  point to the goal
-}
findTheGoal :: Int -> Point -> [Point] -> [WorkItem] -> Maybe Int
findTheGoal nr goal visited [] = Nothing
findTheGoal nr goal visited xs = x where
  h = head xs
  d = depth h
  p = point h
  next = nextSteps (fst p) (snd p) nr
  nextNotVisited = filter (\t -> (t `elem` visited) == False) next
  nextWorkItems = map (\c -> WorkItem c (d+1)) nextNotVisited
  x = if p == goal then
       Just d
      else
        findTheGoal nr goal (p : visited) ((tail xs) ++ nextWorkItems)

{-
  Part 2
------------------
  Performs a breadth-first search to all positions at most 'depth steps from
  the starting point.
-}
findAllPos :: Int -> Int -> [Point] -> [WorkItem] -> Maybe [Point]
findAllPos depth' nr visited [] = Nothing
findAllPos depth' nr visited xs = x where
  h = head xs
  d = depth h
  p = point h
  next = nextSteps (fst p) (snd p) nr
  nextNotVisited = filter (\t -> (t `elem` visited) == False) next
  nextWorkItems = map (\c -> WorkItem c (d+1)) nextNotVisited
  x = if d > depth' then
       Just $ nub visited
      else
        findAllPos depth' nr (p : visited) ((tail xs) ++ nextWorkItems)
