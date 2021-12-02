(ns clj.day6)

(def memory (into (sorted-map-by >) (zipmap (range) [11 11 13 7 0 15 5 5 4 4 1 1 7 1 15 11])))

(defn update-memory [key memory]
  (loop [idx (memory key)
         key2 key
         m2 (update memory key (fn [_] 0))
         ]
    (if (zero? idx)
      m2
      (let [newKey (mod (inc key2) (count m2))
            newMemory (update m2 newKey inc)
            ]
        (recur (dec idx) newKey newMemory)
        )
      )
    )
  )

(defn step1 []
  (loop [counter 1
         m memory
         seenConfigs (set [])
         ]
    (let [key (key (apply max-key val m))
          m2 (update-memory key m)
          ]
      (if (some? (seenConfigs m2))
        counter
        (recur (inc counter) m2 (conj seenConfigs m2)))
      )
    )
  )

(def stepCounter (atom 0))

(def foundConfig (atom {}))

(defn step2 []
  (loop [m memory
         seenConfigs (set [])
         ]
    (let [k (key (apply max-key val m))
          m2 (update-memory k m)
          ]
      (when (not= @foundConfig {})
        (swap! stepCounter inc)
        )
      (if (= @foundConfig m2)
        @stepCounter
        (let []
          (when (some? (seenConfigs m2))
            (when (= @foundConfig {})
              (swap! foundConfig (fn [_] m2))
              )
            )
          (recur m2 (conj seenConfigs m2))
          )
        )
      )
    )
  )

(defn day6 []
  (println (str "Step 1: " (step1)))
  (println (str "Step 1: " (step2)))
  )

