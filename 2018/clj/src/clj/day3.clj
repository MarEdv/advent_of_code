(ns clj.day3)

(defn directions [] (cycle [[1 0] [0 1] [-1 0] [0 -1]]))

(def nrMovementsCalls (atom 0))

(def tempDirections (atom {:directions (directions)}))

(defn movements []
  (let [s (take 1 (@tempDirections :directions))
        t (take 1 (drop 1 (@tempDirections :directions)))
        ]
    (swap! nrMovementsCalls inc)
    (swap! tempDirections assoc :directions (drop 2 (@tempDirections :directions)))
    (concat (repeat @nrMovementsCalls s) (repeat @nrMovementsCalls t) (lazy-seq (movements)))
    )
  )

(defn updateStep1 [incFunc acc d]
  (let [nr (first acc)
        coords (second acc)
        grid (second (rest acc))
        newCoords [(+ (first coords) (first (first d)))
                   (+ (second coords) (second (first d)))]
        newNr (incFunc [nr newCoords grid])
        newGrid (assoc grid newCoords newNr)
        ]
    [newNr
     newCoords
     newGrid
     ]
    )
  )

(defn moveStep [goal incFunc]
  (swap! nrMovementsCalls (fn [a] 0))
  (swap! tempDirections (fn [a] {:directions (directions)}))

  (let [moves (movements)
        initialElement [1 [0 0] {[0 0] 1}]
        ]
    (reduce #(if (>= (first %1) goal) (reduced %1) (updateStep1 incFunc %1 %2))
            initialElement
            moves)
    )
  )

(defn first-spiral [n]
  (let [a (moveStep n (fn [a]
                        (inc (first a))
                        ))
        ]
    (reduce + (map  #(Math/abs %) (second a)))
    )
  )

(defn second-spiral [n]
  (let [acc (moveStep n (fn [a]
                          (let [coords (second a)
                                x (first coords)
                                y (second coords)
                                grid (second (rest a))
                                ]
                            (+
                              (get grid [(inc x) y] 0)
                              (get grid [x (inc y)] 0)
                              (get grid [(dec x) y] 0)
                              (get grid [x (dec y)] 0)
                              (get grid [(inc x) (inc y)] 0)
                              (get grid [(inc x) (dec y)] 0)
                              (get grid [(dec x) (dec y)] 0)
                              (get grid [(dec x) (inc y)] 0)
                              (get grid [x y] 0)
                              )
                            )
                          ))
        ]
    (first acc)
    )
  )

(defn day3 []
  (println (str "Step 1: " (first-spiral 312051)))
  (println (str "Step 2: " (second-spiral 312051)))
  )
