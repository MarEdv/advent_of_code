(ns clj.day11
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(defn readFile [fileName]
  (-> (io/resource fileName)
      (slurp)
      (as-> n (str/split n #","))
      )
  )

(def directions {
           "n"  [1 0 -1]
           "ne" [1 -1 0]
           "se" [0 -1 1]
           "s"  [-1 0 1]
           "sw" [-1 1 0]
           "nw" [0 1 -1]
           })

(defn take-step [[acc max-distance] item]
  (let [newAcc (mapv + acc (directions item))]
    [newAcc (max max-distance (apply max newAcc))]
    )
  )

(defn step1 []
  (->> (readFile "day11.txt")
       (reduce take-step [[0 0 0] 0])
       (first)
       (apply max)
       )
  )

(defn step2 []
  (->> (readFile "day11.txt")
       (reduce take-step [[0 0 0] 0])
       (second)
       )
  )
; With help from: https://www.redblobgames.com/grids/hexagons/
(defn day11 []
  (println (str "Step 1: " (step1)))
  (println (str "Step 2: " (step2)))
  )