(ns clj.core
  (:gen-class)
  (:require [clj.day1])
  (:require [clj.day2])
  )

(defn -main
  [& args]
  (println "Day1!")
  (clj.day1/day1)
  (println "Day2!")
  (clj.day2/day2)
  )
