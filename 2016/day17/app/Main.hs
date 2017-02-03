module Main where

import Lib
import Data.List

main :: IO ()
main = do
  putStrLn "Part 1"
  let Just part1Path = findLowerRight minimumBy "veumntbg" "" 0 0
  putStrLn $ "Path = " ++ part1Path
  putStrLn "Part 2"
  let Just part2Path = findLowerRight maximumBy "veumntbg" "" 0 0
  putStrLn $ "Path length = " ++ (show $ length part2Path)
