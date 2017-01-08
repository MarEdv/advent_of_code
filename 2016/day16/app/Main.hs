module Main where

import Lib

main :: IO ()
main = do
  putStrLn "Part 1"
  putStrLn $ "Checksum = " ++ (checkSum $ generateData2 272 "01000100010010111")
  putStrLn "Part 2"
  putStrLn $ "Checksum = " ++ (checkSum $ generateData2 35651584 "01000100010010111")
