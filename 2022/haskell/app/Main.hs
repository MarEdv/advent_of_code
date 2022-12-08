module Main where

import Day01 ( day01Step1, day01Step2 )
import Day02 ( day02Step1, day02Step2 )
import Day03 ( day03 )
import Day04 ( day04, day04Step1, day04Step2 )
import Day05 ( day05, day05Step1, day05Step2 )
import Day06 ( day06, day06Step1, day06Step2 )
import Day07 ( day07, day07Step1, day07Step2 )
import Day08 ( day08, day08Step1, day08Step2 )

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