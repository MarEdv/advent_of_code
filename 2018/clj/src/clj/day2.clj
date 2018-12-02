(ns clj.day2
  (:require [clojure.java.io :as io]
            [clojure.math.combinatorics :as comb]
            [clojure.string :as str]))

(defn loadInput [fileName]
  (-> (io/resource fileName)
      (io/reader)
      (line-seq)
      )
  )

(defn has-n-duplicates [n coll]
  (->> (group-by identity coll)
       (filter (fn [a] (= n (count (val a)))))
       (empty?)
       (not)
       )
  )

(defn count-n-duplicates [n coll]
  (let [f (partial has-n-duplicates n)]
    (->> (map seq coll)
         (map f)
         (filter #(true? %))
         (count)
         )
    )
  )

(defn checkSum-part1 []
  (let [input (loadInput "day2.txt")]
    (* (count-n-duplicates 2 input)
       (count-n-duplicates 3 input))
    )
  )

(defn equal-pairs [[a b]]
  (->> (map vector a b)
       (filter (fn [[x y]] (= x y)))
       )
  )

(defn diff-by-one [[a b]]
  (= (dec (count a))
     (count (equal-pairs [a b]))
     )
  )

(defn checkSum-part2 []
  (let [input (loadInput "day2.txt")]
    (->> (comb/combinations input 2)
         (filter diff-by-one)
         (first)
         (equal-pairs)
         (map (fn [[a _]] a))
         (str/join "")
         )
    )
  )

(defn day2 []
  (println (str "Part 1: " (checkSum-part1)))
  (println (str "Part 2: " (checkSum-part2)))
  )