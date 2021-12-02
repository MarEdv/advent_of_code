(ns clj.day4
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(defn aFilter [f in]
  (let [pairs (for [x in, y in] (list x y))
        wds (filter (fn [a] (f (first a) (second a))) pairs)]
    (if (> (count wds) (count in)) 0 1)))

(defn step1 [input]
  (reduce + (map (partial aFilter #(= %1 %2)) input)))

(defn step2 [input]
  (reduce + (map (partial aFilter #(= (sort (seq %1)) (sort (seq %2)))) input)))

(defn readFile [fileName]
  (->> (line-seq (io/reader (io/resource fileName)))
       (map #(str/split % #" "))
      )
  )

(defn day4 []
  (let [input (readFile "day4.txt")]
    (println (str "Step 1: " (step1 input)))
    (println (str "Step 2: " (step2 input)))))
