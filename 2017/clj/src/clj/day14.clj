(ns clj.day14
  (:require [clojure.java.io :as io]
            [clojure.string :as str]
            [clj.day10 :as day10]
            ))

(defn prepareInput [input]
  (concat (map int input) [17 31 73 47 23]
          )
  )

(defn calc-knot [input]
  (let [iterations (range 64)
        encryptionData (range 256)
        initialElement [encryptionData 0 0]
        modifiedInputData (prepareInput input)
        ]
    (day10/knot-it-multiple modifiedInputData encryptionData iterations)
    )
  )

(defn transform [input]
  (->> (partition 16 input)
       (map #(reduce (fn [acc item] (bit-xor acc item)) %))
       (map #(format "%02x" %))
       (into [])
       (str/join)
       )
  )

(defn createInput [x]
  (->> (str "ugkiagan-" (String/valueOf x))
       )
  )

(defn fillLeft [s]
  (concat (repeat (- 4 (count s)) \0) s)
  )

(defn toBinary [s]
  (->> (seq s)
       (map str)
       (map #(Integer/parseInt % 16))
       (map #(Integer/toBinaryString %))
       (map fillLeft)
       (map seq)
       (flatten)
       )
  )

(defn calculateBinaryGrid []
  (->> (for [x (range 128)] (createInput x))
       (pmap #(calc-knot %))
       (map transform)
       (map toBinary))
  )

(defn step1 []
  (->> (calculateBinaryGrid)
       (map #(filter (fn [a] (= a \1)) %))
       (map #(count %))
       (reduce +)
       )
  )

(defn day14 []
  (println (str "Step 1: " (step1)))
  )
