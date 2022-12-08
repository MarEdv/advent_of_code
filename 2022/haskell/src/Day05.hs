{-# LANGUAGE OverloadedStrings #-}

module Day05
    (
      day05Step1
    , day05Step2
    , day05
    ) where
import qualified Data.Vector.Mutable as MV
import qualified Data.Vector as V
import Text.Regex
import Control.Monad.Primitive
import Data.List (foldl')
import qualified Control.Monad as M

day05Step1 :: [String] -> IO String
day05Step1 x = do
  doIt reverse x

day05Step2 :: [String] -> IO String
day05Step2 x = do
  doIt id x

doIt f x = do
  let (stack, moves) = break (=="") x
  stacks <- stacks' (formatStacks stack)
  mv <- makeMoves stacks f (tail moves)
  v <- V.freeze mv
  return $ map head (V.toList v)

formatStacks :: [String] -> [String]
formatStacks stacks = do

   ["PZMTRCN", "ZBSTND", "GTCFRQHM", "ZRG", "HRNZ", "DLZPWSHF", "MGCRZDW", "QZWHLFJS", "NWPQS"]

day05 :: IO()
day05 = do
   content <- readFile "day05.txt"
   let linesOfFiles = lines content
   putStrLn "Day 05"
   a <- day05Step1 linesOfFiles
   putStrLn $ "\tStep 1: " ++ show a
   b <- day05Step2 linesOfFiles
   putStrLn $ "\tStep 2: " ++ show b

-- ["NZ", "DCM", "P"]
-- ["PZMTRCN", "ZBSTND", "GTCFRQHM", "ZRG", "HRNZ", "DLZPWSHF", "MGCRZDW", "QZWHLFJS", "NWPQS"]
stacks' :: PrimMonad m => [String] -> m (MV.MVector (PrimState m) [Char])
stacks' stacks = V.thaw $ V.fromList stacks

makeMoves :: PrimMonad m => MV.MVector (PrimState m) [Char] -> ([Char] -> [Char]) -> [String] -> m (MV.MVector (PrimState m) [Char])
makeMoves mv f moves = do
  M.foldM (makeMove f) mv moves

makeMove :: PrimMonad m => ([Char] -> [Char]) -> MV.MVector (PrimState m) [Char] -> String -> m (MV.MVector (PrimState m) [Char])
makeMove f mv instruction = do
   let move = parseInstruction instruction
   case move of
      Just (_count, _from, _to) -> do
         fs <- MV.read mv (_from - 1)
         let fs' = take _count fs
         tos <- MV.read mv (_to - 1)
         let tos' = f fs' ++ tos
         MV.write mv (_to - 1) tos'
         MV.write mv (_from - 1) (drop _count fs)
         return mv

parseInstruction :: String -> Maybe (Int, Int, Int)
parseInstruction instruction =
    case matchRegex (mkRegex "move ([0-9]+) from ([0-9]+) to ([0-9]+)") instruction of
        Just [a, b, c] -> Just (read a, read b, read c)
        Nothing -> Nothing
