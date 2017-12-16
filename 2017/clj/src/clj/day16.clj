(ns clj.day16
  (:require
    [clojure.string :as str]
    [clojure.java.io :as io])
  )

(defn parse [action]
  (let [a (re-matches #"([sxp])([0-9a-p]+)(/([0-9a-p]+))?" action)]
    (case (a 1)
      "s"     {:action (a 1)
               :length   (Integer/valueOf (a 2))}
      "x"     {:action (a 1)
               :from   (Integer/valueOf (a 2))
               :to     (Integer/valueOf (a 4))}
      "p"    {:action (a 1)
              :from   (a 2)
              :to     (a 4)}


      )
    )
  )

(defn loadInput [fileName]
  (-> (io/resource fileName)
      (slurp)
      (str/split #",")
      (as-> x (map parse x))
      (into [])
      )
  )

(defn spin [programs spinSize]
  (let [c (cycle programs)
        d (drop (- (count programs) spinSize) c)
        ]
    (take (count programs) d)
    )
  )

(defn exchange [programs from to]
  (let [a (programs from)
        b (programs to)
        ]
    (-> (assoc programs from b)
        (assoc to a))
    )
  )

(defn partner [programs from to]
  (let [a (.indexOf programs from)
        b (.indexOf programs to)]
    (exchange programs a b)
    )
  )

(defn perform [actions programs]
  (let [a (actions :action)]
    (case a
      "s" (spin programs (actions :length))
      "x" (exchange programs (actions :from) (actions :to))
      "p" (partner programs (actions :from) (actions :to))
      )
    )
  )

(defn dance [as ps]
  (loop [actions as
         programs ps
         ]
    (if (= (count actions) 0)
      programs
      (recur (rest actions) (into [] (perform (first actions) programs)))
      )
    )
  )

(defn step1 [fileName]
  (let [actions (loadInput fileName)
        programs (into [] (map str (seq "abcdefghijklmnop")))]
    (dance actions programs)
    )
  )

(defn step2 [fileName]
  (let [actions (loadInput fileName)
        programs (into [] (map str (seq "abcdefghijklmnop")))
        thisDance (partial dance actions)
        c (take-while #(not= programs %) (drop 1 (iterate thisDance programs)))
        cSize (inc (count c))
        ]
    (reduce str (first (drop (dec (mod 1000000000 cSize)) c)))
    )
  )