(ns clj.day20
  (:require [clojure.java.io :as io]))

(defn parse [line]
  (let [ms (re-matches #"p=<([-\d]+),([-\d]+),([-\d]+)>, v=<([-\d]+),([-\d]+),([-\d]+)>, a=<([-\d]+),([-\d]+),([-\d]+)>" line)
        match-to-int (partial #(Integer/parseInt (ms %)))
        ]
    {:p [(match-to-int 1) (match-to-int 2) (match-to-int 3)]
     :v [(match-to-int 4) (match-to-int 5) (match-to-int 6)]
     :a [(match-to-int 7) (match-to-int 8) (match-to-int 9)]}
    )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       )
  )

(defn move [particle]
  (let [point (particle :p)
        velocity (particle :v)
        acceleration (particle :a)
        new-velocity (mapv + velocity acceleration)
        ]
    {:p (mapv + point new-velocity)
     :v new-velocity
     :a acceleration}
    )
  )

(defn move-all [particles]
  (->> particles
       (map move))
  )

(defn distance [particle]
  (let [point (particle :p)]
    (reduce + (map #(Math/abs %) point))
    )
  )

(defn index-of-closest [particles]
  (->> (map distance particles)
       (mapv vector (range))
       (map (fn [[idx p]] {idx p}))
       (into {})
       (apply min-key val)
       (key)
       )
  )

(def testParticles [
                    {:p [3 0 0] :v [2 0 0] :a [-1 0 0]}
                    {:p [4 0 0] :v [0 0 0] :a [-2 0 0]}
                    {:p [5 0 0] :v [0 0 0] :a [-2 0 0]}
                    {:p [4 0 0] :v [0 0 0] :a [-2 0 0]}
                    ])

(defn filter-colliding-particles [particles]
  (->> (group-by (fn [a] ((second a) :p)) particles)
       (map val)
       (filter #(= 1 (count %)))
       (map first)
       )
  )

(defn move-and-collide [indexed-particles]
  (->> (map (fn [[idx particle]]
              [idx (move particle)])
            indexed-particles
            )
       (filter-colliding-particles)
       )
  )

(defn part1 []
  (->> (readFile "day20.txt")
       (iterate move-all)
       (drop 400)
       (first)
       (index-of-closest)
       )
  )

(defn part2 []
  (->> (readFile "day20.txt")
       (mapv vector (range))
       (iterate move-and-collide)
       (drop 400)
       (first)
       (count)
       )
  )

(defn day20 []
  (println (str "Part 1: " (part1)))
  (println (str "Part 2: " (part2)))
  )