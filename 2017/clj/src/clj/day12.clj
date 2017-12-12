(ns clj.day12
  (:require [clojure.java.io :as io]
            [clojure.set :as set]
            [clojure.string :as str]))

(defn parse [line]
  (let [ms (re-matches #"([\d]+) <-> ([ ,\d]+)" line)]
    {(get ms 1)
     (-> (get ms 2)
         (str/split #", ")
         )
     }
    )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       (into (sorted-map))
       )
  )

(defn search-rec [key visited the-map]
  (let [neighbours (the-map key)
        notVisited (remove #(contains? visited %) neighbours)
        visitedWithCurrent (conj visited key)
        ]
    (conj (map #(search-rec % visitedWithCurrent the-map) notVisited) key)
    )
  )


(defn search [key visited the-map]
  (->> (search-rec key visited the-map)
       (flatten)
       (distinct)
       )
  )

(defn step-1 []
  (->> (readFile "day12.txt")
       (search "0" (set []))
       (count)
       )
  )

(defn step-2 []
  (let [input (readFile "day12.txt")
        keys (map key input)
        ]

    (->> (map #(search % (set []) input) keys)
         (distinct)
         (map set)
         (set)
         (count)
         )
    )
  )

(defn day12 []
  (println (str "Step 1: " (step-1)))
  (println (str "Step 2: " (step-2)))
  )
