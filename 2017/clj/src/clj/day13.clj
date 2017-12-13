(ns clj.day13
  (:require [clojure.java.io :as io]
            [clojure.set :as set]
            [clojure.string :as str]))

(defn parse [line]
  (let [ms (re-matches #"([\d]+): (\d+)" line)]
    {(Integer/parseInt (get ms 1))
     (Integer/parseInt (get ms 2))
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

(defn traverse-firewall [sum-func delay input]
  (let [keys (map key input)]
    (reduce #(let [x (input %2)
                   layer-steps (- (* 2 x) 2)]
               (if (= 0
                      (mod (+ %2 delay) layer-steps)
                      )
                 (sum-func %1 %2 x)
                 %1
                 )
               )
            0 keys)

    )
  )

(defn step-1 []
  (let [input (readFile "day13.txt")]
    (traverse-firewall #(+ %1 (* %3 %2)) 0 input)
    )
  )

(defn step-2 []
  (let [input (readFile "day13.txt")]
    (reduce #(let []
               (if (= 0 (traverse-firewall (fn [_ x _] (reduced x)) %2 input))
                 (reduced %2) %1))
            (range)
            )
    )
  )

(defn day13 []
  (println (str "Step 1: " (step-1)))
  (println (str "Step 2: " (step-2)))
  )
