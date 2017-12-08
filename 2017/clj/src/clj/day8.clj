(ns clj.day8
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.set :as set]))

(defn parse [line]
  (let [ms (re-matches #"([a-z]+) (inc|dec) (-?\d+) if ([a-z]+) ([!=<>]+) (-?\d+)" line)]
    {:reg      (get ms 1)
     :op       (get ms 2)
     :val      (Integer/parseInt (get ms 3))
     :cond-reg (get ms 4)
     :cond-op  (get ms 5)
     :cond-val (Integer/parseInt (get ms 6))
     }
    )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       )
  )

(defn get-item [acc key]
  (get acc key 0)
  )

(defn if-null [n]
  (if (= n nil) 0 n)
  )

(defn evaluate [acc val]
  (let [value (val :cond-val)
        reg (get-item acc (val :cond-reg))]
    (case (val :cond-op)
      ">" (> reg value)
      "<" (< reg value)
      ">=" (>= reg value)
      "<=" (<= reg value)
      "==" (= reg value)
      "!=" (not= reg value)
      false
      )
    )
  )

(def max-reg-val (atom 0))

(defn upd [acc val]
  (update acc (val :reg) (fn [a]
                           (let [aa (if-null a)]
                             (swap! max-reg-val (fn [b] (max aa b)))
                             (if (= "inc" (val :op))
                               (+ aa (val :val))
                               (- aa (val :val))
                               )
                             )
                           )
          )
  )


(defn step-1 []
  (->> (readFile "day8.txt")
       (reduce (fn [acc v]
                 (if (evaluate acc v)
                   (upd acc v)
                   acc
                   )
                 ) {})
       (apply max-key val)
       (val)
       )
  )

(defn step-2 []
  (step-1)
  @max-reg-val
  )

(defn day8 []
  (println (str "Step 1: " (step-1)))
  (println (str "Step 2: " (step-2)))
  )
