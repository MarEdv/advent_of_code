module Main where

import Lib

main :: IO ()
main = do
  putStrLn "Part 1"
  putStrLn $ "Press the button at time = " ++ (show part1Func)
  putStrLn "Part 2"
  putStrLn $ "Press the button at time = " ++ (show part2Func)
