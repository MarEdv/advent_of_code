module Main (main) where

import Lib18

main :: IO ()
main = do
  putStrLn ("toTrap: " ++ (show $ toTrap ('.', '^', '.')))
  putStrLn ("nextRow: " ++ (nextRow puzzleInput))
  let step1length = calculateRows 0 40 puzzleInput
  putStrLn $ "Part 1: " ++ (show step1length)
  let step2length = calculateRows 0 400000 puzzleInput
  putStrLn $ "Part 2: " ++ (show step2length)
