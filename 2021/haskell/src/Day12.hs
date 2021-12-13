{-# LANGUAGE OverloadedStrings #-}

module Day12
    (
      day12
    ) where
import Data.List (sort, groupBy, (\\), nub, group, maximumBy)
import Data.List.Split (splitOn)
import Data.Maybe (fromJust)
import Data.Map (Map, fromList, (!))
import Data.Char (isUpper, isLower)


day12Step1 :: [String] -> Int
day12Step1 x = do
  let graph = loadGraph x
  let ds = dfs graph "start" []
  length ds

dfs :: Map String [String] -> String -> [String] -> [[String]]
dfs _ "end" visited = [["end"]]
dfs graph node visited = do
  let v = updateVisited visited node
  let neighbours = filter (`notElem` v) (graph ! node)
  concatMap (\a -> map (node :) (dfs graph a v)) neighbours

updateVisited :: [String] -> String -> [String]
updateVisited visited node = if all isUpper node then visited else node : visited

loadGraph :: [String] -> Map String [String]
-- loadGraph :: [String] -> [([Char], [[Char]])]
loadGraph x = do
  let splitted = map (splitOn "-") x
  let flipped = map reverse splitted
  let sorted = sort (splitted ++ flipped)
  let grouped = groupBy (\ (a:a':as) (b:b':bs) -> a == b) sorted
  let nodes = map (\a -> ((head.head) a, map (head . tail) a)) grouped
  fromList nodes

dfs2 :: Map String [String] -> String -> [String] -> [[String]]
dfs2 _ "end" visited = [["end"]]
dfs2 graph node visited = do
  let v = updateVisited visited node
  let neighbours = filter (\a -> a `notElem` v && a /= "start") (graph ! node)
  let neighbours2 = filter (\a -> all isLower a && a /= "end" && a /= "start") (graph ! node)
  let grouped = group $ sort v
  let max' = length $ maximumBy (\a b -> compare (length a) (length b)) grouped
  if max' == 1 then
    concatMap (\a -> map (node :) (dfs2 graph a v)) (nub (neighbours ++ neighbours2))
  else
    concatMap (\a -> map (node :) (dfs2 graph a v)) neighbours

day12Step2 :: [String] -> Int
day12Step2 x = do
  let graph = loadGraph x
  let ds = dfs2 graph "start" []
  length ds

day12 :: IO()
day12 = do
   content <- readFile "day12.txt"
   let linesOfFiles = lines content
   putStrLn "Day 12"
   putStrLn $ "\tStep 1: " ++ show (day12Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day12Step2 linesOfFiles)

