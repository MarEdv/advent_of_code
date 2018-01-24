(ns clj.day14
  (:require [clojure.java.io :as io]
            [clojure.string :as str]
            [clj.day10 :as day10]
            [clojure.set :as set]))

(def test-grid [[\0 \1 \0 \1]
                [\1 \1 \0 \0]
                [\0 \0 \1 \0]
                [\1 \1 \1 \1]
                ])

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
  (->> (str "flqrgnkx-" (String/valueOf x))
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

(def directions [[0 1] [1 0] [-1 0] [0 -1]])

(defn within-boarders? [grid a]
  (and (<= 0 a)
       (> (count grid) a)
       )
  )

(defn walk-group [grid visited coords]
  (if (not= (get (get grid (second coords)) (first coords)) \1)
    [(conj visited coords) []]
    (let [candidates (map #(map + % coords) directions)
          validCandidates (filter #(every? (partial within-boarders? grid) %) candidates)
          notVisitedCandidates (filter #(not (contains? visited %)) validCandidates)
          ]
      (if (contains? visited coords)
        [(conj visited coords) []]
        (reduce (fn [[v n] c] (let [[v2 n2] (walk-group grid v c)]
                                [v2 (concat n n2)]
                                ))[(conj visited coords) [coords]] notVisitedCandidates)
        )
      )
    )
  )

(defn identifyGroups
  [grid]
  (loop [v (set [])
         groups []
         coords (for [x (range 128) y (range 128)] (vector x y))
         ]
    (if (empty? coords)
      groups
      (let [c (first coords)
            [v2 group] (walk-group grid v c)
            g2 (if (empty? group)
                 groups
                 (cons group groups)
                 )
            ]
        ;(println (str c))
        (recur (set/union v2 v) g2 (rest coords))
        )
      )
    )
  )

(defn step2 []
  (->> (calculateBinaryGrid)
       (map vec)
       (vec)
       (identifyGroups)
       (count)
       )
  )

(defn day14 []
  (println (str "Step 1: " (step1)))
  (println (str "Step 2: " (step2)))
  )
