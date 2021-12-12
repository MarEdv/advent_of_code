module Main where

import Day01 ( day01Step1, day01Step2 )
import Day02 ( day02Step1, day02Step2 )
import Day03 ( day03Step1, day03Step2 )
import Day04 ( day04Step1, day04Step2 )
import Day05 ( day05Step1, day05Step2 )
import Day06 ( day06Step1, day06Step2 )
import Day07 ( day07Step1, day07Step2 )
import Day08 ( day08Step1, day08Step2 ) 
import Day09 ( day09Step1, day09Step2 ) 
import Day10 ( day10Step1, day10Step2 ) 
import Day11 ( day11Step1, day11Step2 ) 

main :: IO ()
main = do
  day01
  day02
  day03
  day04
  day05
  day06
  day07
  day08
  day09
  day10
  day11

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

day03 :: IO()
day03 = do
   content <- readFile "day03.txt"
   let linesOfFiles = lines content
   putStrLn "Day 3"
   putStrLn $ "\tStep 1: " ++ show (day03Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day03Step2 linesOfFiles)

day04 :: IO()
day04 = do
   content <- readFile "day04.txt"
   let linesOfFiles = lines content
   putStrLn "Day 4"
   putStrLn $ "\tStep 1: " ++ show (day04Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day04Step2 linesOfFiles)

day05 :: IO()
day05 = do
   content <- readFile "day05.txt"
   let linesOfFiles = lines content
   putStrLn "Day 5"
   putStrLn $ "\tStep 1: " ++ show (day05Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day05Step2 linesOfFiles)

day06 :: IO()
day06 = do
   content <- readFile "day06.txt"
   let linesOfFiles = lines content
   putStrLn "Day 6"
   putStrLn $ "\tStep 1: " ++ show (day06Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day06Step2 linesOfFiles)

day07 :: IO()
day07 = do
   content <- readFile "day07.txt"
   let linesOfFiles = lines content
   putStrLn "Day 7"
   putStrLn $ "\tStep 1: " ++ show (day07Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day07Step2 linesOfFiles)

day08 :: IO()
day08 = do
   content <- readFile "day08.txt"
   let linesOfFiles = lines content
   putStrLn "Day 8"
   putStrLn $ "\tStep 1: " ++ show (day08Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day08Step2 linesOfFiles)

day09 :: IO()
day09 = do
   content <- readFile "day09.txt"
   let linesOfFiles = lines content
   putStrLn "Day 9"
   putStrLn $ "\tStep 1: " ++ show (day09Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day09Step2 linesOfFiles)

day10 :: IO()
day10 = do
   content <- readFile "day10.txt"
   let linesOfFiles = lines content
   putStrLn "Day 10"
   putStrLn $ "\tStep 1: " ++ show (day10Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day10Step2 linesOfFiles)

day11 :: IO()
day11 = do
   content <- readFile "day11.txt"
   let linesOfFiles = lines content
   putStrLn "Day 11"
   putStrLn $ "\tStep 1: " ++ show (day11Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day11Step2 linesOfFiles)
