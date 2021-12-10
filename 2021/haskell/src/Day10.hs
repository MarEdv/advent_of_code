{-# LANGUAGE OverloadedStrings #-}

module Day10
    (
      day10Step1
    , day10Step2
    ) where
import Data.List (sort)

day10Step1 :: [String] -> Int
day10Step1 x = do
  let parsed = map (parseChunks "") x
  let filtered = filter (not.null) (map fst parsed)
  sum $ map charValue filtered

charValue :: Maybe Char -> Int
charValue Nothing = error "What"
charValue (Just ')') = 3
charValue (Just ']') = 57
charValue (Just '}') = 1197
charValue (Just '>') = 25137
charValue _ = error "Ehhh..."

charValue2 :: Char -> Int
charValue2 ')' = 1
charValue2 ']' = 2
charValue2 '}' = 3
charValue2 '>' = 4
charValue2 _ = error "Ehhh..."

day10Step2 :: [String] -> Int
day10Step2 x = do
  let parsed = map (parseChunks "") x
  let filtered = filter (null . fst) parsed
  let chars = map snd filtered
  let mappedChars = map (map match) chars
  let scores = map (foldl (\acc i -> acc * 5 + charValue2 i) 0) mappedChars
  let sortedScores = sort scores
  let middleScore = sortedScores !! (length sortedScores `div` 2)
  middleScore

parseChunks :: String -> String -> (Maybe Char, String)
parseChunks chars [] = (Nothing, chars)
parseChunks chars string = do
  if head string `elem` ("([{<" :: [Char]) then
    parseChunks (head string : chars) (tail string)
  else if head string == match (head chars) then
    parseChunks (tail chars) (tail string)
  else
    (Just (head string), chars)

match :: Char -> Char
match char = case char of
  '(' -> ')'
  '<' -> '>'
  '[' -> ']'
  '{' -> '}'
  _ -> error (char : "")