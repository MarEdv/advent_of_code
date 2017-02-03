module Lib
    ( isActive
    , newPosition
    , newPositions
    , findLowerRight
    ) where

import Data.Digest.Pure.MD5
import Data.ByteString.Lazy.Char8 (pack)
import Data.Maybe
import Data.List
import Data.Ord

findLowerRight :: (Foldable t0) => ((t0 a0 -> t0 a0 -> Ordering) -> [String] -> String) -> String -> String -> Int -> Int -> Maybe String
findLowerRight orderingFunc string path x y = relevantPath where
  hash = show $ md5 $ pack (string ++ path)
  newPos = newPositions x y hash

  maybePaths :: [Maybe String]
  maybePaths = map (\(d, x1, y1) ->
             if x1 == 3 && y1 == 3
             then
               Just (path ++ d)
             else
               findLowerRight orderingFunc string (path ++ d) x1 y1) newPos

  possiblePaths = maybePaths >>= maybeToList
  relevantPath = case possiblePaths of
    [] -> Nothing
    bs -> Just (orderingFunc (comparing length) bs)

newPositions :: Int -> Int -> String -> [(String, Int, Int)]
newPositions x1 y1 string = x where
  s = (\x y -> if isActive y
               then x
               else 'X'
      )
  y = [
        s 'U' (string!!0)
      , s 'D' (string!!1)
      , s 'L' (string!!2)
      , s 'R' (string!!3)
      ]
  z = filter (\x -> x /= 'X') y
  d = map (\x -> newPosition x1 y1 x) z
  x = filter (\x -> isOK x) d

newPosition :: Int -> Int -> Char -> (String, Int, Int)
newPosition x y char
  | char == 'U' = ("U",x,y-1)
  | char == 'D' = ("D",x,y+1)
  | char == 'L' = ("L",x-1,y)
  | char == 'R' = ("R",x+1,y)

isActive :: Char -> Bool
isActive char = char `elem` ['b'..'f']

isOK :: (String, Int, Int) -> Bool
isOK (_,x,y) =
  x >= 0 && x <= 3 &&
  y >= 0 && y <= 3
