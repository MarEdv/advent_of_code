(ns clj.day23
  (:require [clojure.java.io :as io])
  )

(defn parse [line]
  (let [res (re-matches #"(set|sub|mul|jnz) ([a-z0-9])( ([-a-z0-9]+))?" line)]
    {:instr (get res 1) :X (get res 2) :Y (get res 4)}
    )
  )

(defn readFile [fileName]
  (->> (io/resource fileName)
       (io/reader)
       (line-seq)
       (map parse)
       (into [])
       )
  )

(defn parse-int [number-string]
  (try (Integer/parseInt number-string)
       (catch Exception e nil)))

(defn resolveRef [regs reg]
  (let [value (get regs reg 0)]
    (if (number? reg)
      reg
      (if (nil? (parse-int reg))
        (if (number? value)
          value
          (if (nil? (parse-int value))
            (get regs value 0)
            (parse-int value)
            )
          )
        (parse-int reg)
        )
      )
    )
  )

(defn handle [instrs idx regs invocations]
  (let [reg (get instrs idx)
        x (get reg :X)
        xVal (resolveRef regs (get reg :X))
        yVal (resolveRef regs (get reg :Y))
        zVal (resolveRef regs (get reg :Z))
        aVal (resolveRef regs (get reg :A))
        ]
    (case (reg :instr)
      "set" [(inc idx) (assoc! regs x yVal) invocations]
      "sub" [(inc idx) (assoc! regs x (- xVal yVal)) invocations]
      "mul" [(inc idx) (assoc! regs x (* xVal yVal)) (inc invocations)]
      "jnz" [(if (zero? xVal) (inc idx) (+ idx yVal)) regs invocations]
      )
    )
  )

(defn execute [instrs registers]
  (loop [[idx regs invocations] (handle instrs 0 (transient registers) 0)
         i 0
         ]
    (if (or (neg? idx) (>= idx (count instrs)))
      [invocations (persistent! regs)]
      (recur (handle instrs idx regs invocations) (inc i))
      )
    )
  )

; Thanks https://github.com/fardog/is-prime for the help ;)
(defn- test-prime
  "Determine if a number is prime by looping through divisors"
  [x]
  (loop [iter 2 top (int (Math/sqrt x))]
    (if (> iter top)
      true
      (if (= 0 (mod x iter))
        false
        (recur (inc iter) top)))))

(defn is-prime
  "Determines if a given integer is prime."
  [x]
  (if (< x 2)
    false
    (test-prime x)))
; End thanks

(defn part1 []
  (let [instrs (readFile "day23.txt")]
    (first (execute instrs {}))
    )
  )

(defn part2 []
  (->> (range (- 125400 17000) 125401 17)
       (filter #(not (is-prime %)))
       (count)
       )
  )

(defn day23 []
  (println (str "Part 1: " (part1)))
  (println (str "Part 2: " (part2)))
  )