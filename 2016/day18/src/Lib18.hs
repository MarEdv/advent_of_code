module Lib18 (calculateRows, toTrap, puzzleInput, nextRow) where

puzzleInput :: String
puzzleInput = ".^^.^^^..^.^..^.^^.^^^^.^^.^^...^..^...^^^..^^...^..^^^^^^..^.^^^..^.^^^^.^^^.^...^^^.^^.^^^.^.^^.^."

toTrap :: (Char, Char, Char) -> Char
toTrap (x,y,z)
  | x == '^' && y == '^' && z == '.' = '^'
  | x == '.' && y == '^' && z == '^' = '^'
  | x == '^' && y == '.' && z == '.' = '^'
  | x == '.' && y == '.' && z == '^' = '^'
  | otherwise = '.'

nextRow :: String -> String
nextRow row = x where
  l = zip3 ("." ++ row) row (drop 1 row ++ ".")
  x = map (\f -> toTrap f) l

calculateRows :: Int -> Int -> String -> Int
calculateRows count n string = do
  let m = length $ filter (== '.') string
  if (n == 0)
      then
        count
      else
        calculateRows (m+count) (n-1) (nextRow string)
