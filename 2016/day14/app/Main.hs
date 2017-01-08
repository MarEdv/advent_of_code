module Main where

import Lib

main :: IO ()
main = do
  putStrLn "Step 1"
  putStrLn (show $ findKeys hashIndexPart1 "qzyelonm" 0 63)
  putStrLn "Step 2"
  putStrLn (show $ findKeys hashIndexPart2 "qzyelonm" 0 63)
