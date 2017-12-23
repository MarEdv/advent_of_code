(ns clj.day19
  (:require [clojure.java.io :as io])
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map vec)
       (into [])
       )
  )

(defn findStartPos [grid]
  (.indexOf (first grid) \|)
  )


(defn getPos [grid x y]
  (if (or (<= (count grid) y)
          (neg? y))
    \space
    (if (or (<= (count (grid y)) x)
            (neg? x))
      \space
      ((grid y) x)
      )
    )
  )

(defn finished? [grid x y]
  (= (getPos grid x y) \space)
  )

(def directions {"down" [0 1]
           "up"       [0 -1]
           "right"       [1 0]
           "left"       [-1 0]})

(def symbols {"down" \-
           "up"    \-
           "right"    \|
           "left"    \|
           })

(defn nextPos [grid x y dir]
  (mapv + (directions dir) [x y])
  )

(defn newDirection [grid newX newY dir]
  (->> (dissoc directions dir)
       (map key)
       (map #(conj (nextPos grid newX newY %) %))
       (filter (fn [[x y _]] (or (re-matches #"[A-Z]" (str (getPos grid x y)))
                                 (= (symbols dir) (getPos grid x y)))))
       (first)
       (rest)
       (second)
       )
  )

(defn move [grid x y dir letters steps]
  (let [[newX newY] (nextPos grid x y dir)
        symbol (getPos grid newX newY)
        newDir (newDirection grid newX newY dir)
        ]
    (case symbol
      \space [newX newY dir letters (inc steps)]
      \| [newX newY dir letters (inc steps)]
      \- [newX newY dir letters (inc steps)]
      \+ [newX newY newDir letters (inc steps)]
      (move grid newX newY dir (conj letters symbol) (inc steps))
      )
    )
  )

(defn walk-the-walk [grid]
  (let [startX (findStartPos grid)]
    (loop [[x y dir letters steps] [startX 0 "down" [] 0]]
      (if (finished? grid x y)
        [(reduce str letters) steps]
        (recur (move grid x y dir letters steps))
        )
      )
    )
  )

(defn day19 []
  (let [grid (readFile "day19.txt")
        result (walk-the-walk grid)]
    (println (str "Part 1: " (first result)))
    (println (str "Part 2: " (second result)))
    )
  )