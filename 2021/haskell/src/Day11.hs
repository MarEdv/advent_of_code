{-# LANGUAGE OverloadedStrings #-}

module Day11
    (
      day11Step1
    , day11Step2
    ) where
import Data.List.Split (chunksOf)
import Data.Matrix (fromLists, Matrix (ncols, nrows), toList, mapPos, setElem, getElem, zero)
import Data.List (foldl')
import Debug.Trace (trace)

day11Step1 :: [String] -> Int
day11Step1 x = do
  let m = loadMatrix x
  let (flashes, m') = foldr (\_ (acc, m') -> f acc m') (0, m) [1..100]
  let c = nrows m'
  flashes + (c - c)

loadMatrix :: [String] -> Matrix Int
loadMatrix x = do
  let intLists = map (map (\a -> read a :: Int) . chunksOf 1) x
  fromLists intLists

f :: Int -> Matrix Int -> (Int, Matrix Int)
f acc m = (acc + a, m')
  where (a, m') = process m

process :: Matrix Int -> (Int, Matrix Int)
process m = do
  let positions = [(x,y)| x <- [1..ncols m], y <- [1..nrows m]]
  let (updatedCount, m') = update m positions
  (updatedCount, m')

update :: Matrix Int -> [(Int, Int)] -> (Int, Matrix Int)
update m positions = do
  let m' = updateOnce m positions
  let updatedCount = length $ filter (== 10) (toList m')
  (updatedCount, mapPos (\(x, y) a -> if a == 10 then 0 else a) m')

updateOnce :: Matrix Int -> [(Int, Int)] -> Matrix Int
updateOnce m [] = m
updateOnce m positions = do
  let m' = updateCell (head positions) m Nothing
  updateOnce m' (tail positions)

updateCell :: (Int, Int) -> Matrix Int -> Maybe (Int, Int)-> Matrix Int
updateCell (x,y) m origin = do
  let value = getElem y x m
  let newValue = min (value+1) 10
  let m' = setElem newValue (y,x) m
  if value == 9 then
    let
      ns = getNeighbours x y m'
      ns' = (case origin of
        Nothing -> ns
        Just x1 -> filter (/= x1) ns)
    in
      foldr (\ i acc -> updateCell i acc (Just (x,y))) m' ns'
  else
    m'

getNeighbours :: Int -> Int -> Matrix Int -> [(Int, Int)]
getNeighbours x y m = do
  let ns = [(x',y') | x' <- [max 1 (x-1)..min (ncols m) (x+1)], y' <- [max 1 (y-1)..min (nrows m) (y+1)]]
  let a = filter (/= (x, y)) ns
  filter (\(x,y) -> 10 /= getElem y x m) a

day11Step2 :: [String] -> Int
day11Step2 x = do
  let m = loadMatrix x
  let zeroM = zero (nrows m) (ncols m)
  let (steps, m') = head $ dropWhile (\(n,m') -> m' /= zeroM) $ iterate (\(n, m') -> (n+1, snd (process m'))) (0, m)
  steps

day11 :: IO()
day11 = do
   content <- readFile "day11.txt"
   let linesOfFiles = lines content
   putStrLn "Day 11"
   putStrLn $ "\tStep 1: " ++ show (day11Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day11Step2 linesOfFiles)
