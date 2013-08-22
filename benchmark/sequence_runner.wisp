(ns sequence-runner
	(:require [benchmark :refer [Suite]]
			  [wisp.runtime :refer [= <]]
			  [wisp.sequence :refer [lazy-seq lazy-seq? list list? cons
			  						 sequential? reverse map filter reduce
			  						 count empty? first second third rest last
			  						 butlast take take-while drop conj assoc
			  						 concat seq vec sort repeat every? some
			  						 partition interleave nth]]))

(def suite (Suite.))

;; Sequence functions
(.add suite "lazy-seq" (fn [] (lazy-seq (+ 1 1))))
(.add suite "lazy-seq?" (fn [] (lazy-seq? (lazy-seq (+ 1 1)))))
(.add suite "list" (fn [] (list 1 2 3)))
(.add suite "list?" (fn [] (list? (list 1 2 3))))
(.add suite "cons" (fn [] (cons 1 '(2 3))))
(.add suite "sequential?" (fn [] (sequential? [1 2 3])))
(.add suite "reverse" (fn [] (reverse (list 3 2 1))))
(.add suite "map" (fn [] (map (fn [x] (+ x 1)) [1 2 3])))
(.add suite "filter" (fn [] (filter (fn [x] (= 0 (mod x 2))) [1 2 3 4 5])))
(.add suite "reduce" (fn [] (reduce (fn [x y] (+ x y)) 0 [1 2 3])))
(.add suite "count" (fn [] (count [1 2 3])))
(.add suite "empty?" (fn [] (empty? [])))
(.add suite "first" (fn [] (first [1 2 3])))
(.add suite "second" (fn [] (second [1 2 3])))
(.add suite "third" (fn [] (third [1 2 3])))
(.add suite "rest" (fn [] (rest [1 2 3])))
(.add suite "last" (fn [] (last [1 2 3])))
(.add suite "butlast" (fn [] (butlast [1 2 3])))
(.add suite "take" (fn [] (take 2 [1 2 3])))
(.add suite "take-while" (fn [] (take-while (fn [x] (< x 4)) [1 2 3 4 5])))
(.add suite "drop" (fn [] (drop 3 [1 2 3 4 5])))
(.add suite "conj" (fn [] (conj [1 2 3] 4 5)))
(.add suite "assoc" (fn [] (assoc {"one" 1 "two" 2} "three" 3)))
(.add suite "concat" (fn [] (concat '(1 2 3) '(4 5))))
(.add suite "seq" (fn [] (seq [1 2 3])))
(.add suite "vec" (fn [] (vec (list 1 2 3))))
(.add suite "sort" (fn [] (sort [3 5 1 4 2])))
(.add suite "repeat" (fn [] (repeat 5 "five")))
(.add suite "every?" (fn [] (every? (fn [x] (= 0 (mod x 2))) [2 4 6 8])))
(.add suite "some" (fn [] (some (fn [x] (= 0 (mod x 2))) [2 4 6 8])))
(.add suite "partition" (fn [] (partition 2 [1 2 3 4 5 6])))
(.add suite "interleave" (fn [] (interleave [1 3 5] [2 4])))
(.add suite "nth" (fn [] (nth [1 2 3 4 5] 3)))

(.on suite "start" (fn [] (print "Starting Wisp sequence benchmarks...\n")))
(.on suite "cycle" (fn [event] (print (String (.-target event)))))
(.on suite "error" (fn [event] (print "ERROR: Could not run benchmark:" (String (.-target event)))))
(.on suite "complete" (fn [] (print "\nDone.")))

(.run suite {"async": true})

