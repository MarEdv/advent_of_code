(ns clj.day15
  (:require [clojure.java.io :as io]
            [clojure.string :as str]
            ))

(def nominator 2147483647)
(def aTerm 16807)
(def bTerm 48271)

(def bit-mask 2r1111111111111111)

(defn compareBitwise [a b]
  (let [newA (bit-and a bit-mask)
        newB (bit-and b bit-mask)
        ]
    (= newA newB)
    )
  )

(defn calcNewVal [curr term multiple]
  (loop [a curr]
    (let [na (rem (* a term) nominator)]
      (if (= (mod na multiple) 0)
        na
        (recur na)
        )
      )
    )
  )

(defn generate [newValuesFunc acc item]
  (let [currA (acc :a)
        currB (acc :b)
        currCount (acc :count)
        [newA newB] (newValuesFunc currA currB)
        newCount (if (compareBitwise newA newB) (inc currCount) currCount)
        ]
    (when (= (rem item 1000000) 0) (println (str item)))
    {:a newA :b newB :count newCount}
    )
  )

(defn step1 []
  (reduce (partial generate #(list (rem (* %2 aTerm) nominator)
                                   (rem (* %2 aTerm) nominator)))
          {:a 634 :b 301 :count 0}
          (range 40000000)
          )
  )

(defn step2 []
  (reduce (partial generate #(list (calcNewVal %1 aTerm 4)
                                   (calcNewVal %2 bTerm 8)))
          {:a 634 :b 301 :count 0}
          (range 5000000)
          )
  )

(defn day15 []
  (println (str "Step 1: " (step1)))
  (println (str "Step 2: " (step2)))
  )
