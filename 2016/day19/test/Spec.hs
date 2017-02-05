import Test.HUnit
import Lib

main :: IO ()
main = do
  counts <- runTestTT testList
  putStrLn $ showCounts $ counts

test1 = TestCase (assertEqual "example from website, step 1" (step1 [1..5]) 3)
test2 = TestCase (assertEqual "example from website, step 2" (step2 [1..5]) 2)

testList = TestList [test1, test2]

