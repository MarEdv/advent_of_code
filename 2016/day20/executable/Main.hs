import System.Environment
import Data.List.Split
import Data.List
import Data.Range.Range

main :: IO ()
main = do
   args <- getArgs
   content <- readFile (args !! 0)
   let linesOfFiles = lines content
   let d = map splitIt linesOfFiles
   let f = map parseIt d
   let g = sortOn fst f
   let h = map (\x -> SpanRange (fst x) (snd x)) g
   let j2 = filter (\x -> not $ inRanges h x) [0..4294967295]
   putStrLn $ "Part 1: " ++ (show $ head $ take 1 j2)
   let i = foldl mergeRanges2 [head g] (tail g)
   let j = foldl calculateDiff (0,(4294967296,0)) i
   putStrLn $ "Part 2: " ++ (show $ fst j)

splitIt :: String -> (String,String)
splitIt string = x where
  y = splitOn "-" string
  x = (head y,head $ tail y)

parseIt :: (String,String) -> (Int,Int)
parseIt (x,y) = (read x, read y)

mergeRanges2 :: [(Int, Int)] -> (Int, Int) -> [(Int, Int)]
mergeRanges2 a b = z where
  c = head a
  z = if (snd c + 1 >= fst b) then
        (fst c, max (snd b) (snd c)) : tail a
      else
        b : a

calculateDiff :: (Int, (Int, Int)) -> (Int, Int) -> (Int, (Int, Int))
calculateDiff (i,a) b = (n,b) where
  n = i + fst a - snd b - 1
