import Test.HUnit
import Lib

test1 = TestCase (assertEqual "" (cellType 0 0 10) (Space))
test2 = TestCase (assertEqual "" (cellType 1 0 10) (Wall))
test3 = TestCase (assertEqual "" (cellType 2 0 10) (Space))
test4 = TestCase (assertEqual "" (cellType 3 0 10) (Wall))
test5 = TestCase (assertEqual "" (cellType 0 1 10) (Space))
test6 = TestCase (assertEqual "" (cellType 1 1 10) (Space))
test7 = TestCase (assertEqual "" (cellType 2 1 10) (Wall))
test8 = TestCase (assertEqual "" (cellType 3 1 10) (Space))
test9 = TestCase (assertEqual "" (cellType 0 2 10) (Wall))
test10 = TestCase (assertEqual "" (cellType 1 2 10) (Space))
test11 = TestCase (assertEqual "" (cellType 2 2 10) (Space))

test20 = TestCase (assertEqual "" (nextSteps 0 0 10) ([(0,1)]))
test21 = TestCase (assertEqual "" (nextSteps 3 1 10) ([(4,1),(3,2)]))
test22 = TestCase (assertEqual "" (nextSteps 7 0 10) ([(7,1)]))

testList = TestList [test1
                    , test2
                    , test3
                    , test4
                    , test5
                    , test6
                    , test7
                    , test8
                    , test9
                    , test10
                    , test11
                    , test20
                    , test21
                    , test22
                    ]

main :: IO ()
main = do
  counts <- runTestTT testList
  putStrLn $ showCounts $ counts
