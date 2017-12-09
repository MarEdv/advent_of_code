(ns clj.day9
  (:require [clojure.java.io :as io]))

(defn readFile [fileName]
  (->> (io/resource fileName)
       (slurp)
       (seq)
       )
  )

(defn handle [acc char]
  (if (= \! (acc :prev))
    (assoc acc :prev "")
    (if (= (acc :mode) "garbage")
      (case char
        \> (assoc acc :mode "normal")
        \! (assoc acc :prev \!)
        (assoc acc :garbage (inc (acc :garbage)))
        )
      (case char
        \{ (assoc acc :depth (inc (acc :depth)) :sum (+ (acc :sum) (acc :depth)) :prev "")
        \} (assoc acc :depth (dec (acc :depth)) :prev "")
        \< (assoc acc :mode "garbage")
        \! (assoc acc :prev \!)
        acc
        )
      )
    )
  )

(defn parseInput [fileName]
  (let [tokenList (readFile fileName)
        startElement {:depth 1 :sum 0 :prev "" :mode "normal" :garbage 0}]
    (reduce handle startElement tokenList)
    )
  )
(defn step-1 []
  ((parseInput "day9.txt") :sum)
  )

(defn step-2 []
  ((parseInput "day9.txt") :garbage)
  )

(defn day9 []
  (println (str "Step 1: " (step-1)))
  (println (str "Step 2: " (step-2)))
  )
