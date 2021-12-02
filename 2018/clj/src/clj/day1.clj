(ns clj.day1
  (:require [clojure.java.io :as io]))

(defn calculate-frequency-1
  [input]
  (reduce + input)
  )

(defn calculate-frequency-2
  [list]
  (->> (cycle list)
       (reduce (fn [[a b] i]
                 (let [n ]
                   )
                 )
               [#{} 0])
       )
  )

(defn day1 []
  (let [input (->> (io/resource "day1.txt")
                   (io/reader)
                   (line-seq)
                   (map #(Integer/parseInt %))
                   )]
    (println (str "Part 1: " (calculate-frequency-1 input)))
    (println (str "Part 2: " (calculate-frequency-2 input)))
    )
  )