{-# LANGUAGE OverloadedStrings #-}

module Day07
    (
      day07Step1
    , day07Step2
    , day07
    ) where
import Data.List (partition, find, foldl', intercalate, reverse, sortOn)
import Data.Char (isDigit)
import Text.Regex
import Debug.Trace (trace)

day07Step1 :: [String] -> Int
day07Step1 x = do
  let result = handleCommand [] x []
  let r = calculateSizes "/" result
  sum $ map snd (filter (\(x, y) -> y <= 100000) r)

day07Step2 :: [String] -> Int
day07Step2 x = do
  let result = handleCommand [] x []
  let r = calculateSizes "/" result
  let sortedR = reverse $ sortOn snd r
  let usedDisk = (snd . head) sortedR
  (snd . last) $ takeWhile (\x -> snd x > (30000000 - (70000000 - usedDisk))) sortedR

day07 :: IO()
day07 = do
   content <- readFile "day07.txt"
   let linesOfFiles = lines content
   putStrLn "Day 07"
   putStrLn $ "\tStep 1: " ++ show (day07Step1 linesOfFiles)
   putStrLn $ "\tStep 2: " ++ show (day07Step2 linesOfFiles)

type FileEntry = (String, Int)

data Node = Node {
  fileEntries :: [FileEntry]
  , dirs :: [String]
} deriving (Show)

handleCommand :: [String] -> [String] -> [(String, Node)] -> [(String, Node)]
handleCommand path input result
  | null input = result
  | cmdHead7 == "$ cd .." = handleCommand (tail path) inputTail result
  | cmdHead4 == "$ cd" = handleCommand (dir : path) inputTail result
  | cmdHead4 == "$ ls" = handleCommand path lsNextInput (lsEntries : result)
  | otherwise = trace ("hej: " ++ show path) result
  where
    inputHead = head input
    cmdHead4 = take 4 inputHead
    cmdHead7 = take 7 inputHead
    dir = drop 5 inputHead
    inputTail = tail input
    entries = takeWhile (\x -> head x /= '$') inputTail
    lsEntries = ls entries path
    lsNextInput = drop (length entries) inputTail

ls :: [String] -> [String] -> (String, Node)
ls entries path = ("/" ++ intercalate "/" (tail (reverse path)), Node { fileEntries = files', dirs = dirs' }) where
  (files, dirs) = partition (isDigit . head) entries
  dirs' = map (drop 4) dirs
  files' = map toFileEntry files

toFileEntry :: String -> FileEntry
toFileEntry string =
    case matchRegex (mkRegex "([0-9]+) ([a-zA-Z\\.]+)") string of
        Just [a, b] -> (b, read a)
        Nothing -> error $ "error: " ++ string

calculateSizes :: String -> [(String, Node)] -> [(String, Int)]
calculateSizes cwd input = (dir, sizeSum) : result where
  (dir, entry) = case find (\x -> cwd == fst x) input of
    Just (dir, entry) -> (dir, entry)
    Nothing -> error ("err calc: " ++ cwd)
  filesSize = sum $ map snd (fileEntries entry)
  dirsSizes = map (mapDir cwd input) (dirs entry)
  result = concatMap snd dirsSizes
  sizeSum = filesSize + foldl' (\acc item -> acc + fst item) 0 dirsSizes

mapDir :: String -> [(String, Node)] -> String -> (Int, [(String, Int)])
mapDir pathString input cwd = (size, sizes) where
  newPath = case pathString of
    "/" -> "/" ++ cwd
    _ -> pathString ++ "/" ++ cwd
  sizes = calculateSizes newPath input
  Just (dir, size) = find (\x -> newPath == fst x) sizes
