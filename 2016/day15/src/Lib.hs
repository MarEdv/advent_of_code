module Lib
    ( part1Func
    , part2Func
    ) where

{-

A list of tuples with 7 positions represents the time and the positions of
of the 6 discs at that time. The list is filtered for the first element
that represents the configuration of the 6 discs such that
- disc 1 has to move 1 steps to reach position 0
- disc 2 has to move 2 steps to reach position 0
...
- disc 6 has to move 6 steps to reach position 0

-}
part1Func :: Int
part1Func = x where
 list = [( x
         , (x+1)`mod`13
         , (x+10)`mod`19
         , (x+2)`mod`3
         , (x+1)`mod`7
         , (x+3)`mod`5
         , (x+5)`mod`17) | x <- [0..]]
 l2 = filter (\x -> case x of
                 (_,12,17,0,3,0,11) -> True
                 _ -> False
             ) list
 (x,_,_,_,_,_,_) = head $ take 1 l2

{-

 This time we added a 7th disc according to the assignment. Otherwise, this is
the same type of solution as for part 1.

-}
part2Func :: Int
part2Func = x where
 list = [( x
         , (x+1)`mod`13
         , (x+10)`mod`19
         , (x+2)`mod`3
         , (x+1)`mod`7
         , (x+3)`mod`5
         , (x+5)`mod`17
         , (x+0)`mod`11)| x <- [0..]]
 l2 = filter (\x -> case x of
                 (_,12,17,0,3,0,11,4) -> True
                 _ -> False
             ) list
 (x,_,_,_,_,_,_,_) = head $ take 1 l2
