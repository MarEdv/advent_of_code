module Lib
    ( generateData
    , generateData2
    , checkSum
    ) where

generateData :: String -> String
generateData string = string ++ "0" ++ b where
  r = reverse string
  b = map (\x -> case x of
              '0' -> '1'
              '1' -> '0'
          ) r

generateData2 :: Int -> String -> String
generateData2 length' string = data' where
  d = generateData string
  data' =
    if length d >= length' then
      take length' d
    else
      generateData2 length' d

checkSum :: String -> String
checkSum string = s where
  l = zip3 [1..] string (drop 1 string)
  l2 = filter (\x -> case x of
                  (a,_,_) -> odd a) l
  l3 = map (\x -> case x of
               (a,'1','1') -> '1'
               (a,'0','0') -> '1'
               _ -> '0'
           ) l2
  s =
    if odd $ length l3 then
      l3
    else
      checkSum l3
