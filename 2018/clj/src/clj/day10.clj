(ns clj.day10
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(def inputList [14 58 0 116 179 16 1 104 2 254 167 86 255 55 122 244])

(defn knot-it-once [[list index skip] subListLength]
  (let [c (cycle list)
        subList (take subListLength (drop index c))
        reversedSubList (reverse subList)
        overFlowLength (- (+ index subListLength) (count list))
        newIndex (mod (+ index skip subListLength) (count list))
        ]
    [(if (neg? overFlowLength)
       (concat (take index list)
               reversedSubList
               (drop (+ index subListLength) list))
       (concat (drop (- subListLength overFlowLength) reversedSubList)
               (take (- (count list) subListLength) (drop overFlowLength list))
               (take (- subListLength overFlowLength) reversedSubList))
       )
     newIndex
     (inc skip)])
  )

(defn knot-it [data input index step]
  (reduce knot-it-once [data index step] input)
  )

(defn step1 [input]
  (->> (knot-it (range 256) input 0 0)
       (first)
       (take 2)
       (reduce * 1)
       )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (slurp)
       (seq)
       (map (fn [a] (int a)))
       )
  )

(defn knot-it-again [modifiedInputData [data index skip] _]
  (knot-it data modifiedInputData index skip)
  )

(defn knot-it-multiple [modifiedInputData encryptionData iterations]
  (let [initialElement [encryptionData 0 0]
        func (partial knot-it-again modifiedInputData)]
    (->> (reduce func initialElement iterations)
         (first)
         )
    )
  )

(defn step2 []
  (let [inputData (readFile "day10.txt")
        modifiedInputData (concat inputData [17 31 73 47 23])
        iterations (range 64)
        encryptionData (range 256)
        ]
    (->> (partition 16 (knot-it-multiple modifiedInputData encryptionData iterations))
         (map #(reduce (fn [acc item] (bit-xor acc item)) %))
         (map #(format "%02x" %))
         (into [])
         (str/join)
         )
    )
  )

(defn day10 []
  (println (str "Step 1: " (step1 inputList)))
  (println (str "Step 2: " (step2)))
  )
