(ns clj.day17)

(defn red [[l i] item]
  (let [idx (inc (mod (+ i 369) (count l)))]
    [
     (concat (take idx l) [item] (drop idx l))
     idx
     ]
    )
  )

(defn step1 []
  (->> (reduce red [[0] 0] (range 1 2018))
       (first)
       (drop-while #(not= 2017 %))
       (drop 1)
       (first)
       )
  )

(defn red2 [[candidates len i] item]
  (let [idx (mod (+ i 369) len)
        afterZeroCandidates (if (zero? idx) (conj candidates item) candidates)]
    [
     afterZeroCandidates
     (inc len)
     (inc idx)
     ]
    )
  )

(defn step2 [a]
  (->> (reduce red2 [[] 1 0] (range 1 a))
       (first)
       (take-last 1)
       )
  )

(defn day17 []
  (println (str "Step 1: " (step1)))
  (println (str "Step 2: " (step2)))
  )
