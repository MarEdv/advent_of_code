import Test.Tasty
import Test.Tasty.HUnit

import Data.List
import Data.Ord

import Day01 (day01Step1, day01Step2)
import Day02 (day02Step1, day02Step2)
import Day03 (day03Step1, day03Step2)
import Day04 (day04Step1, day04Step2)
import Day05 (day05Step1, day05Step2)
import Day06 (day06Step1, day06Step2)
import Day07 (day07Step1, day07Step2)
import Day08 (day08Step1, day08Step2)

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [unitTests]

unitTests = testGroup "Unit tests"
  [ testCase "Day 01 Step 1" $
      day01Step1 ["1000","2000","3000","","4000","","5000","6000","","7000","8000","9000","","10000"] @?= 24000
  , testCase "Day 01 Step 2" $
      day01Step2 ["1000","2000","3000","","4000","","5000","6000","","7000","8000","9000","","10000"] @?= 45000

  , testCase "Day 02 Step 1" $
      day02Step1 ["A Y", "B X", "C Z"] @?= 15
  , testCase "Day 02 Step 2" $
      day02Step2 ["A Y", "B X", "C Z"] @?= 12

  , testCase "Day 03 Step 1" $
      day03Step1 ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"] @?= 157
  , testCase "Day 03 Step 2" $
      day03Step2 ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"] @?= 70

  , testCase "Day 04 Step 1" $
      day04Step1 ["2-4,6-8","2-3,4-5","5-7,7-9","2-8,3-7","6-6,4-6","2-6,4-8"] @?= 2
  , testCase "Day 04 Step 2" $
      day04Step2 ["5-7,7-9","2-8,3-7", "6-6,4-6","2-6,4-8"] @?= 4

--   , testCase "Day 05 Step 1" $
--       day05Step1 ["2-4,6-8","2-3,4-5","5-7,7-9","2-8,3-7","6-6,4-6","2-6,4-8"] @?= "CMZ"
--   , testCase "Day 05 Step 2" $
--       day05Step2 ["5-7,7-9","2-8,3-7", "6-6,4-6","2-6,4-8"] @?= "MCD"

  , testCase "Day 06 Step 1" $
      day06Step1 ["bvwbjplbgvbhsrlpgdmjqwftvncz"] @?= 5
  , testCase "Day 06 Step 2" $
      day06Step2 ["mjqjpqmgbljsphdztnvjfqwrcgsmlb"] @?= 19

  , testCase "Day 07 Step 1" $
      day07Step1 ["$ cd /","$ ls","dir a","14848514 b.txt","8504156 c.dat","dir d","$ cd a","$ ls","dir e","29116 f","2557 g","62596 h.lst","$ cd e","$ ls","584 i","$ cd ..","$ cd ..","$ cd d","$ ls","4060174 j","8033020 d.log","5626152 d.ext","7214296 k"] @?= 95437
  , testCase "Day 07 Step 2" $
      day07Step2 ["$ cd /","$ ls","dir a","14848514 b.txt","8504156 c.dat","dir d","$ cd a","$ ls","dir e","29116 f","2557 g","62596 h.lst","$ cd e","$ ls","584 i","$ cd ..","$ cd ..","$ cd d","$ ls","4060174 j","8033020 d.log","5626152 d.ext","7214296 k"] @?= 24933642

  , testCase "Day 08 Step 1" $
      day08Step1 ["30373","25512","65332","33549","35390"] @?= 21
  , testCase "Day 08 Step 2" $
      day08Step2 ["30373","25512","65332","33549","35390"] @?= 8
  ]