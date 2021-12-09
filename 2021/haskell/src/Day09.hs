{-# LANGUAGE OverloadedStrings #-}

module Day09
    (
      day09Step1
    , day09Step2
    ) where

import Data.Matrix
import Data.List.Split (chunksOf)
import Data.Set (Set, empty, member, insert)
import Data.List (sort, sortBy)

day09Step1 :: [String] -> Int
day09Step1 x = do
  findRiskLevelSum (loadMatrix x)

loadMatrix :: [String] -> Matrix Int
loadMatrix x = do
  let ints = map (map (\a -> read a :: Int) . chunksOf 1) x
  fromLists ints

findRiskLevelSum :: Matrix Int -> Int
findRiskLevelSum m = do
  let get = (\(x,y) -> unsafeGet y x m)
  let lowPoints = getLowPoints m
  let riskLevels = map (\(position,_) -> 1 + get position) lowPoints
  sum riskLevels

findBasins :: Matrix Int -> Int
findBasins m = do
  let lowPoints = getLowPoints m
  let basinSizes = findBasinsSizes m (map fst lowPoints)
  product (take 3 (sortBy (flip compare) basinSizes)) 

getLowPoints :: Matrix Int -> [((Int, Int), [(Int, Int)])]
getLowPoints m = do
  let cols = ncols m
  let rows = nrows m
  let get = (\(x,y) -> unsafeGet y x m)
  let positions = [(x,y) | x <- [1..cols], y <- [1..rows]]
  let positionsToNeighbours = map (\point -> (point,validPoints cols rows point)) positions
  filter (\(position,xs) -> get position < minimum (map get xs)) positionsToNeighbours

validPoints :: Int -> Int -> (Int,Int) -> [(Int,Int)]
validPoints cols rows (x,y) = do
  filter (/= (x,y)) [
    (max (x-1) 1,y),
    (min (x+1) cols,y),
    (x,max (y-1) 1),
    (x,min (y+1) rows)
    ]

findBasinsSizes :: Matrix Int -> [(Int, Int)] -> [Int]
findBasinsSizes m positions = do
  let basins = map (findB m empty) positions
  map fst basins

findB :: Matrix Int -> Set (Int,Int) -> (Int,Int) -> (Int, Set (Int,Int))
findB m visited origin = if member origin visited then
    (0, visited)
  else
    let points = validPoints (ncols m) (nrows m) origin
        vpoints = filter (\(x,y) -> 9 > unsafeGet y x m) points
        (acc, v) = foldl (\(acc,v) point -> let (i, v') = findB m v point
          in (acc + i,v'))
          (0,insert origin visited)
          vpoints
    in (acc+1,v)

day09Step2 :: [String] -> Int
day09Step2 x = do
  findBasins (loadMatrix x)