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
    (if (>= idx (count instrs))
      [idx regs sound rcvSound]
      (case (reg :instr)
        "snd" [(inc idx) regs xVal rcvSound]
        "set" [(inc idx) (assoc regs x yVal) sound rcvSound]
        "add" [(inc idx) (assoc regs x (+ xVal yVal)) sound rcvSound]
        "mul" [(inc idx) (assoc regs x (* xVal yVal)) sound rcvSound]
        "mod" [(inc idx) (assoc regs x (mod xVal yVal)) sound rcvSound]
        "rcv" [(inc idx) regs sound (if (zero? xVal) rcvSound sound)]
        "jgz" [(if (pos? xVal) (+ idx yVal) (inc idx)) regs sound rcvSound])
      )
    )
  )

(defn execute [instrs]
  (loop [ins instrs
         [idx regs sound rcvSound] (handle ins 0 {} 0 0)
         ]
    (if (not (zero? rcvSound))
      rcvSound
      (recur ins (handle ins idx regs sound rcvSound))
      )
    )
  )

(defn part1 []
  (let [instrs (readFile "day18.txt")]
    (execute instrs)
    )
  )

(defn handle2 [instrs idx regs input output]
  (let [reg (get instrs idx)
        x (get reg :X)
        xVal (resolveRef regs (get reg :X))
        yVal (resolveRef regs (get reg :Y))
        ]
    (if (or(and (empty? input)
                (= (reg :instr) "rcv"))
           (>= idx (count instrs)))
      [idx regs input output true]
      (case (reg :instr)
        "snd" [(inc idx) regs input (concat output [xVal]) false]
        "set" [(inc idx) (assoc regs x yVal) input output false]
        "add" [(inc idx) (assoc regs x (+ xVal yVal)) input output false]
        "mul" [(inc idx) (assoc regs x (* xVal yVal)) input output false]
        "mod" [(inc idx) (assoc regs x (mod xVal yVal)) input output false]
        "rcv" [(inc idx) (assoc regs x (first input)) (rest input) output false]
        "jgz" [(if (pos? xVal) (+ idx yVal) (inc idx)) regs input output false]
        )
      )
    )
  )

(defn execute-until-stuck [instrs _idx _regs _input _output not-first-invocation]
  (loop [ins instrs
         [idx regs input output yield] (handle2 instrs _idx _regs _input _output)
         ]
    (if (or yield
            (>= idx (count instrs))
            )
      [idx regs input output]
      (recur ins
        (handle2 ins idx regs input output)
        )
      )
    )
  )

(defn part2 []
  (let [instrs (readFile "day18.txt")]
    (loop [[idx1 regs1 input0 output0]
              (execute-until-stuck instrs 0 {"p" 0} [] [] false)
           [idx2 regs2 input1 output1]
              (execute-until-stuck instrs 0 {"p" 1} output0 [] false)
           s (count output1)
            ]
      (if (and (empty? output0) (empty? output1))
        s
        (let [result0 (execute-until-stuck instrs idx1 regs1 output1 [] true)
              _output0 (get result0 3)
              result1 (execute-until-stuck instrs idx2 regs2 _output0 [] true)
              _output1 (get result1 3)
              ]
          (recur result0 result1
            (+ s (count _output1))
            )
          )
        )
      )
    )
  )

(defn day18 []
  (println (str "Part 1: " (part1)))
  (println (str "Part 2: " (part2)))
  )