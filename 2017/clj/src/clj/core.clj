(ns clj.core
  (:gen-class)
  (:require [clj.day1]
            [clj.day2]
            [clj.day3]
            )
  )

(defn -main
  [& args]
  (println "Day1!")
  (clj.day1/day1)
  (println "Day2!")
  (clj.day2/day2)
  (println "Day3!")
  (clj.day3/day3)
  )
