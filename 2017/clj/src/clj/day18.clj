(ns clj.day18
  (:require [clojure.java.io :as io])
  )

(defn parse [line]
  (let [res (re-matches #"(snd|set|add|mul|mod|rcv|jgz) ([a-z0-9])( ([-a-z0-9]+))?" line)]
    ;(println (str))
    (case (get res 1)
      "snd" {:instr (get res 1) :X (get res 2)}
      "rcv" {:instr (get res 1) :X (get res 2)}
      {:instr (get res 1) :X (get res 2) :Y (get res 4)}
      )
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
    ;(println (str "regs " regs " reg " reg " value " value " p " (parse-int value)) " type " (type value))
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

(defn handle [instrs idx regs sound rcvSound]
  (let [reg (get instrs idx)
        x (get reg :X)
        xVal (resolveRef regs (get reg :X))
        yVal (resolveRef regs (get reg :Y))
        ]
    ;(println (str "x " x " xVal " xVal " yVal " yVal))
    (case (reg :instr)
      "snd" [(inc idx) regs xVal rcvSound]
      "set" [(inc idx) (assoc! regs x yVal) sound rcvSound]
      "add" [(inc idx) (assoc! regs x (+ xVal yVal)) sound rcvSound]
      "mul" [(inc idx) (assoc! regs x (* xVal yVal)) sound rcvSound]
      "mod" [(inc idx) (assoc! regs x (mod xVal yVal)) sound rcvSound]
      "rcv" [(inc idx) regs sound (if (zero? xVal) sound sound)]
      "jgz" [(if (pos? xVal) (+ idx yVal) (inc idx)) regs sound rcvSound]
      )
    )
  )

(defn execute [instrs]
  (loop [ins instrs
         [idx regs sound rcvSound] (handle ins 0 (transient {}) 0 0)
         i 0
         ]
    ;(when (= (mod i 1000) 0) (println (str "idx " idx " regs " regs " sound " sound " reg " (get ins idx))))
    (if (not (zero? rcvSound))
      rcvSound
      (recur ins (handle ins idx regs sound rcvSound) (inc i))
      )
    )
  )

(defn part1 []
  (let [instrs (readFile "day18.txt")]
    (execute instrs)
    )
  )

(defn day18 []
  (println (str "Part 1: " (part1)))
  )