(ns clj.day25)

(def test-state-machine {
                         "A" {0 {:write 1 :move 1 :next "B"}
                              1 {:write 0 :move  -1 :next  "B"}
                              }
                         "B" {0 {:write 1 :move  -1 :next  "A"}
                              1 {:write 1 :move  1 :next  "A"}
                              }
                         }
  )

(def part1-state-machine {
                          "A" {0 {:write 1 :move  1 :next  "B"}
                               1 {:write 0 :move  1 :next  "F"}
                               }
                          "B" {0 {:write 0 :move  -1 :next  "B"}
                               1 {:write 1 :move  -1 :next  "C"}
                               }
                          "C" {0 {:write 1 :move  -1 :next  "D"}
                               1 {:write 0 :move  1 :next  "C"}
                               }
                          "D" {0 {:write 1 :move  -1 :next  "E"}
                               1 {:write 1 :move  1 :next  "A"}
                               }
                          "E" {0 {:write 1 :move  -1 :next  "F"}
                               1 {:write 0 :move  -1 :next  "D"}
                               }
                          "F" {0 {:write 1 :move  1 :next  "A"}
                               1 {:write 0 :move  -1 :next  "E"}
                               }
                          }
  )

(defn evaluate
  ([state-machine state]
   (evaluate state-machine {} 0 state)
    )
  ([state-machine tape cursor state]
   (let [value (get tape cursor 0)
         op (get-in state-machine [state value])
         s1 (assoc tape cursor (get op :write))
         new-cursor (+ cursor (get op :move))
         new-state (get op :next)
         ]
     (lazy-seq (cons s1 (evaluate state-machine s1 new-cursor new-state)))
     )
    )
  )

(defn diagnostic-checksum [tape]
  (reduce + (filter #(= 1 %) (map val tape)))
  )

(defn part1 []
  (->> (evaluate part1-state-machine "A")
       (drop (dec 12425180))
       (take 1)
       (first)
       (diagnostic-checksum)
       )
  )

(defn day25 []
  (println (str "Part 1: " (part1)))
  )