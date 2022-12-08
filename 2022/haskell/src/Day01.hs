{-# LANGUAGE OverloadedStrings #-}

module Day01
    (
      day01Step1
    , day01Step2
    ) where
import Data.List (sort)

day01Step1 :: [String] -> Int
day01Step1 x =
  fst $ foldl findMaxCalories (0,0) x

findMaxCalories :: (Int, Int) -> String -> (Int, Int)
findMaxCalories acc "" = case acc of
  (_max,calories) -> (max calories _max, 0)
findMaxCalories acc next = (fst acc, snd acc + (read next :: Int))

day01Step2 :: [String] -> Int
day01Step2 x = do
  let result = foldl findTop3Calories ([],0) x
  sum $ [snd result : fst result] >>=
        return . sort >>= 
          return . reverse >>=
            take 3
  -- sum . take 3 . reverse . sort $ snd result : fst result

findTop3Calories :: ([Int], Int) -> String -> ([Int], Int)
findTop3Calories acc "" = case acc of
  (_max,calories) -> (calories : _max, 0)
findTop3Calories acc next = (fst acc, snd acc + (read next :: Int))
