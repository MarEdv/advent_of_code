(ns clj.day22
  (:require [clojure.java.io :as io]))

(defn parseLine [[y list]]
  (->> (seq list)
       (mapv vector (range))
       (map (fn [[x v]] {[x y] v}))
       )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (mapv vector (range))
       (map parseLine)
       (flatten)
       (into {})
       )
  )

(def directions {:u [0 -1]
                 :l [-1 0]
                 :d [0 1]
                 :r [1 0]
                 })

(def behavior-extended {:u {\# {:dir :r} \. {:dir :l} \W {:dir :u} \F {:dir :d}}
                        :l {\# {:dir :u} \. {:dir :d} \W {:dir :l} \F {:dir :r}}
                        :d {\# {:dir :l} \. {:dir :r} \W {:dir :d} \F {:dir :u}}
                        :r {\# {:dir :d} \. {:dir :u} \W {:dir :r} \F {:dir :l}}
                        }
  )

(def behavior {:u {\# {:dir :r} \. {:dir :l}}
               :l {\# {:dir :u} \. {:dir :d}}
               :d {\# {:dir :l} \. {:dir :r}}
               :r {\# {:dir :d} \. {:dir :u}}
               }
  )

(def infects {\. \#
              \# \.
              }
  )

(def infects-extended {\. \W
                       \W \#
                       \# \F
                       \F \.
                       }
  )

(defn infect [behavior infects [grid [x y] direction infections] _]
  (let [node (get grid [x y] \.)
        newDir (get-in behavior [direction node :dir])
        newNodeStatus (get infects node)
        newPos (mapv + [x y] (get directions newDir))
        ]
    [(assoc grid [x y] newNodeStatus)
     newPos
     newDir
     (if (= newNodeStatus \#) (inc infections) infections)
     ]
    )
  )

(defn walk [input steps behavior infects]
  (let [breadth (int (Math/sqrt (count input)))
        start-point [(int (/ breadth 2)) (int (/ breadth 2))]
        ]
    (->> (reductions (partial infect behavior infects) [input start-point :u 0] (range))
         (drop steps)
         (take 1)
         )
    )
  )

(defn part1 []
  (let [input (readFile "day22.txt")]
    (->> (walk input 10000 behavior infects)
         (first)
         (drop 3)
         (first))
    )
  )

(defn part2 []
  (let [input (readFile "day22.txt")]
    (->> (walk input 10000000 behavior-extended infects-extended)
         (first)
         (drop 3)
         (first))
    )
  )

(defn day22 []
  (println (str "Part 1: " (part1)))
  (println (str "Part 2: " (part2)))
  )