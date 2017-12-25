(ns clj.day24
  (:require [clojure.java.io :as io]
            [ubergraph.core :as uber]
            [ubergraph.alg :as alg]
            )
  )

(defn parse [line]
  (let [ms (re-matches #"([0-9]+)/([0-9]+)" line)]
    (vector (Integer/parseInt (get ms 1))
            (Integer/parseInt (get ms 2))
            )
    )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       )
  )

(defn merge-maps [first-map second-map]
  (->> (concat (keys second-map) (keys first-map))
       (into (sorted-set))
       (map #(hash-map :weight % :succs (concat (get first-map % []) (get second-map % []))))
       )
  )

(defn relations-per-weight [entry]
  (let [relations (for [x (get entry :succs) y (get entry :succs)] (vector x y))
        non-circular-relations (filter (fn [[a b]] (not= a b)) relations)]
    (hash-map :weight (get entry :weight)
              :relations non-circular-relations
              )
    )
  )

(defn relations [input]
  (let [first-map (group-by first input)
        second-map (group-by second input)
        ]
    (->> (merge-maps first-map second-map)
         (map relations-per-weight)
         )
    )
  )

(defn make-graph-from-relations [start-graph relations]
  (reduce (fn [graph node-pair] (uber/add-edges graph node-pair))
          start-graph
          (get relations :relations)
          )
  )
(defn make-graph [input graph]
  (->> (relations input)
       (reduce make-graph-from-relations graph)
       )
  )

(defn get-valid-successors [successors visited next-weight]
  (->> (filter #(not (contains? (set visited) %)) successors)
       (filter #(contains? (set %) next-weight))
       )
  )

(defn get-next-weight [node prev-weight]
  (if (= (first node) prev-weight)
    (second node)
    (first node)
    )
  )

(defn get-all-paths-from-node
  ([graph node] (get-all-paths-from-node graph node {} 0))
  ([graph node visited prev-weight]
   (let [successors (uber/successors graph node)
         new-visited (concat visited [node])
         next-weight (get-next-weight node prev-weight)
         valid-successors (get-valid-successors successors new-visited next-weight)
         ]
     (if (zero? (count valid-successors))
       [new-visited]
       (mapcat #(get-all-paths-from-node graph % new-visited next-weight) valid-successors)
       )
     )
    )
  )

(defn calc-path-weight [graph paths]
  (reduce + (flatten paths))
  )

(defn get-all-paths [graph]
  (->> (uber/nodes graph)
       (filter #(or (zero? (first %)) (zero? (second %))))
       (map #(get-all-paths-from-node graph %))
       (reduce concat)
       )
  )

(defn create-graph []
  (let [input (readFile "day24test.txt")
        graph (uber/build-graph (uber/graph))]
    (make-graph input graph)
    )
  )

(defn part1 []
  (let [graph (create-graph)
        paths (get-all-paths graph)
        ]
    (->> (map (partial calc-path-weight graph) paths)
         (flatten)
         (apply max)
         )
    )
  )

(defn get-max-weight-paths [paths]
  (->> (group-by #(get % :length) paths)
       (sort-by key)
       (reverse)
       (first)
       (val)
       )
  )

(defn part2 []
  (let [graph (create-graph)
        ]
    (->> (get-all-paths graph)
         (map #(hash-map :length (count %) :weight (calc-path-weight graph %)))
         (get-max-weight-paths)
         (map #(get % :weight))
         (apply max)
         )
    )
  )

(defn day24 []
  (println (str "Part 1: " (part1)))
  (println (str "Part 2: " (part2)))
  )