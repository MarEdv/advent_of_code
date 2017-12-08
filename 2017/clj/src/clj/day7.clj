(ns clj.day7
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.set :as set]))

(defn parse [line]
  (let [ms (re-matches #"(.*) \((\d*)\)( -> )*([a-z, ]*)" line)]
    [
     (get ms 1)
     (filter not-empty (string/split (get ms 4) #", "))
     (Integer/parseInt (get ms 2))
     ]
    )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       )
  )

(defn step1 [fileName]
  (let [r (readFile fileName)
        l1 (set (concat (map first r)))
        l2 (set (concat (map second r)))
        l3 (set (reduce concat [] l2))
        ]
    (set/difference l1 l3)
    )
  )

(defn get-item [k l]
  (first (filter (fn [a] (= k (first a))) l))
  )

(defn calc-weight [p programs]
  (let [item (get-item p programs)]
    (->> item
         (second)
         (map (fn [a] (calc-weight a programs)))
         (reduce +)
         (+ (get item 2))
         )
    )
  )

(defn step2 [fileName]
  (let [programs (readFile fileName)
        keys (concat (map first programs))
        ]
    (filter (fn [key]
              (< 1 (->> (get-item key programs)
                        (second)
                        (map (fn [child] (calc-weight child programs)))
                        (set)
                        (count)
                        )
                 )) keys)
    )
  )

(defn day7 []
  (println (str "Step 1: " (step1 "day7.txt")))
  (println (str "Step 2: " (into [] (step2 "day7.txt"))))
  )

