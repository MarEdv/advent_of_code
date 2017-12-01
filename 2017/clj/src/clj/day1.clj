(ns clj.day1
  (:require [clojure.java.io :as io]))

(defn sumPairwiseIfEqual
  [aList bList]
  (if (= (count aList) 0)
    0
    (let [aFirst (first aList)
          bFirst (first bList)
          val (if (= aFirst bFirst) aFirst 0)]
      (+ val (sumPairwiseIfEqual (rest aList) (rest bList)))
      )
    )
  )

(defn toListOfInts [string]
  "Transforms a string of [0-9]* to list of java.lang.Integer."
  (let [list (seq (String/valueOf string))]
    (map (fn [a] (Integer/parseInt (str a))) list)
    )
  )

(defn captcha-first
  [string]
  (let [intList (toListOfInts string)
        list2 (concat (rest intList) [(first intList)])
        ]
    (sumPairwiseIfEqual intList list2)
    )
  )

(defn captcha-second
  [string]
  (let [intList (toListOfInts string)
        halfLength (/ (count intList) 2)
        list2 (concat (drop halfLength intList) (take halfLength intList))
        ]
    (sumPairwiseIfEqual intList list2)
    )
  )

(defn day1 []
  (let [string (slurp (io/resource "day1.txt"))]
    (println (str "Part 1: " (captcha-first string)))
    (println (str "Part 2: " (captcha-second string)))
    )
  )