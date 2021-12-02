(ns clj.day21
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.core.matrix :as m]
            ))

(defn parse [line]
  (let [m (re-matches #"(.+) => (.+)" line)]
    {:from (vec (map vec (string/split (m 1) #"/")))
     :to   (vec (map vec (string/split (m 2) #"/")))
     }
    )
  )

(def startSquare [[\. \# \.]
                  [\. \. \#]
                  [\# \# \#]])

(def test-matrix [[1 2 3 4 5 6]
                  [7 8 9 0 "A" "B"]
                  ["C" "D" "E" "F" "G" "H"]
                  ["I" "J" "K" "L" "M" "N"]
                  ["O" "P" "Q" "R" "S" "T"]
                  ["U" "V" "X" "Z" "Å" "Ä"]])

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       )
  )

(defn split [matrix parts]
  (let [width (m/row-count matrix)
        row-groups (partition parts (range width))
        sub-matrix-indices (for [x row-groups y row-groups] (vector x y))
        ]
    (map (fn [[x y]] (m/submatrix matrix (first x) (count x) (first y) (count y))) sub-matrix-indices)
    )

  )

(defn split-sub-matrices [matrix]
  (let [w (m/row-count matrix)]
    (if (zero? (mod w 2))
      (split matrix 2)
      (split matrix 3)
      )
    )
  )

(defn is [coll key]
  (> (count (filter #(= % key) coll)) 0)
  )

(defn flip [matrix]
  (map reverse matrix)
  )

(defn rotate [matrix]
  (->> (flip matrix)
       (m/transpose)
       )
  )

(defn apply-rules [matrix rules]
  (let [m1 (rotate matrix)
        m2 (rotate m1)
        m3 (rotate m2)
        matrices [matrix m1 m2 m3 (flip matrix) (flip m1) (flip m2) (flip m3)]
        hits (filter (is matrices (% :from)) rules)
        ]
    (if (zero? (count hits))
      matrix
      ((first hits) :to)
      )
    )
  )

(defn merge-sub-matrices [matrices]
  (let [height (int (Math/sqrt (count matrices)))
        parts (vec (partition height matrices))
        w (range height)
        p (range (m/row-count (first matrices)))
        ]
    (if (= 1 (count matrices))
      (first matrices)
      (for [q w x p]
        (mapcat #(get % x) (parts q))
        )
      )
    )
  )

(defn doit [rules matrix]
  (->> (split-sub-matrices matrix)
       (map m/matrix)
       (map #(apply-rules % rules))
       (merge-sub-matrices)
       (m/matrix)
       )
  )

(defn enhance-matrix [x]
  (let [rules (readFile "day21.txt")
        f (partial doit rules)]
    (->> (drop x (iterate f startSquare))
         (flatten)
         (filter #(= (\# %)))
         (count)
         )
    )
  )

(defn day21 []
  (println (str "Part 1: " (enhance-matrix 5)))
  (println (str "Part 2: " (enhance-matrix 18)))
  )