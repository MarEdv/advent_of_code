module Main where

import Lib
import Data.Maybe

main :: IO ()
main = do
  putStrLn "Step 1"
  let steps = findTheGoal 1350 (31,39) [] [WorkItem (1,1) 0]
  putStr "Steps: "
  putStrLn $ show steps
  putStrLn ""
  putStrLn "Step 2"
  let positions = findAllPos 50 1350 [] [WorkItem (1,1) 0]
  putStr "Visited positions: "
  putStrLn $ show $ length $ fromJust positions
