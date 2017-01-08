{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( hashIndexPart1
    , hashIndexPart2
    , findFirstTriplet
    , containsQuintet
    , isOneTimeKey
    , findKeys
    ) where

import Data.Digest.Pure.MD5
import Data.ByteString.Lazy.Char8 (pack)
import Data.List
import Data.Function.Memoize

type HashFunc = (String -> Int -> String)

findKeys :: HashFunc -> String -> Int -> Int -> [Int]
findKeys hashFunc salt index count
  | count == 0 = []
  | otherwise = nk : (findKeys memHashFunc salt (nk+1) (count-1)) where
      memHashFunc = memoize2 hashFunc
      nk = (nextKey memHashFunc salt (index+1))

nextKey :: HashFunc -> String -> Int -> Int
nextKey hashFunc salt index =
  if isOneTimeKey hashFunc salt index then
    index
  else
    nextKey hashFunc salt (index+1)

hashIndexPart1 :: HashFunc
hashIndexPart1 salt index = show $ md5 string where
  string = pack $ salt ++ (show index)

hashIndexPart2 :: HashFunc
hashIndexPart2 salt index = foldl f md5String a64 where
  f = (\acc x -> show $ md5 $ pack acc)
  a64 = replicate 2016 ""
  string = salt ++ (show index)
  md5String = show $ md5 $ pack string

isOneTimeKey :: HashFunc -> String -> Int -> Bool
isOneTimeKey hashFunc salt index = isKey where
  hash = hashFunc salt index
  triplet = findFirstTriplet hash
  isKey = case triplet of
    Nothing -> False
    Just t -> containsQuintet hashFunc salt (index+1) (index+1000) (head t)

containsQuintet :: HashFunc -> String -> Int -> Int -> Char -> Bool
containsQuintet hashFunc salt index maxIndex char
  | maxIndex == index = False
  | otherwise = result where
      quintet = replicate 5 char
      hash = hashFunc salt index
      result =
        if isInfixOf quintet hash then
          True
        else
          containsQuintet hashFunc salt (index+1) maxIndex char

findFirstTriplet :: String -> Maybe String
findFirstTriplet [] = Nothing
findFirstTriplet (x:[]) = Nothing
findFirstTriplet (x1:x2:[]) = Nothing
findFirstTriplet (x1:x2:x3:xs)
  | x1 == x2 && x1 == x3 =
    Just (x1:x2:x3:[])
  | otherwise =
    findFirstTriplet (x2:x3:xs)
