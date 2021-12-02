module Main where

import Day01
import Day02

main :: IO ()
main = do
  day01
  day02

day01 :: IO()
day01 = do
   content <- readFile "day01.txt"
   let linesOfFiles = lines content
   putStrLn "Day 1"
   putStrLn $ "\tStep 1: " ++ show (day01Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day01Step2 linesOfFiles)
  
day02 :: IO()
day02 = do
   content <- readFile "day02.txt"
   let linesOfFiles = lines content
   putStrLn "Day 2"
   putStrLn $ "\tStep 1: " ++ show (day02Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day02Step2 linesOfFiles)
    