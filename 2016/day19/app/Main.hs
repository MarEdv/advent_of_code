module Main where

import Lib

main :: IO ()
main = do
  putStrLn "Step 1"
  putStrLn $ show $ step1 [1..3018458]
  putStrLn "Step 2"
  putStrLn $ show $ step2 [1..3018458]
