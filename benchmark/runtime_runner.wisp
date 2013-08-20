(ns runtime-runner
	(:require [benchmark :refer [Suite]]
            [wisp.runtime :refer [identity odd? even? dictionary? dictionary
                                  keys vals key-values merge contains-vector?
                                  map-dictionary to-string fn? error? string?
                                  number? vector? date? boolean? re-pattern?
                                  object? nil? true? false? re-find re-matches
                                  re-pattern inc dec str char int subs
                                  pattern-equal? date-equal? dictionary-equal?
                                  vector-equal? equivalent? = == > >= < <= + -
                                  / * and or max min]]))

(def suite (Suite.))

;; Runtime functions
(.add suite "identity" (fn [] (identity 1)))
(.add suite "odd?" (fn [] (odd? 101)))
(.add suite "even?" (fn [] (even? 202)))
(.add suite "dictionary?" (fn [] (dictionary? {:one 1 :two 2 :three 3})))
(.add suite "dictionary" (fn [] (dictionary "one" 1 "two" 2 "three" 3)))
(.add suite "keys" (fn [] (let [dict {:one 1 :two 2 :three 3}] (keys dict))))
(.add suite "vals" (fn [] (let [dict {:one 1 :two 2 :three 3}] (vals dict))))
(.add suite "key-values" (fn [] (let [dict {:one 1 :two 2 :three 3}] (key-values dict))))
(.add suite "merge" (fn [] (merge {:one 1 :two 2} {:three 3})))
(.add suite "contains-vector?" (fn [] (contains-vector? [1 2 3 4 5] 3)))
(.add suite "map-dictionary" (fn [] (map-dictionary {"two" 1 "three" 2 "four" 3} (fn [x] (+ x 1)))))
(.add suite "to-string" (fn [] (to-string 90210)))
(.add suite "fn?" (fn [] (fn? (fn [] (+ 1 1)))))
(.add suite "error?" (fn [] (error? (Error. "This is an error."))))
(.add suite "string?" (fn [] (string? "This is a string.")))
(.add suite "number?" (fn [] (number? 1)))
(.add suite "vector?" (fn [] (vector? [1 2 3 4 5])))
(.add suite "date?" (fn [] (date? (Date.))))
(.add suite "boolean?" (fn [] (boolean? true)))
(.add suite "re-pattern?" (fn [] (re-pattern? #"llo")))
(.add suite "object?" (fn [] (object? {:one 1 :two 2 :three 3})))
(.add suite "nil?" (fn [] (nil? nil)))
(.add suite "true?" (fn [] (true? true)))
(.add suite "false?" (fn [] (false? false)))
(.add suite "re-find" (fn [] (re-find #"o" "Hello")))
(.add suite "re-matches" (fn [] (re-matches #"l" "Hello")))
(.add suite "re-pattern" (fn [] (re-pattern "llo")))
(.add suite "inc" (fn [] (inc 1)))
(.add suite "dec" (fn [] (dec 1)))
(.add suite "str" (fn [] (str 1)))
(.add suite "char" (fn [] (char 9)))
(.add suite "int" (fn [] (int 1.0)))
(.add suite "subs" (fn [] (subs "Hello" 2 5)))
(.add suite "pattern-equal?" (fn [] (pattern-equal? #"llo" #"llo")))
(.add suite "date-equal?" (fn [] (let [d1 (.parse Date "Dec 25, 1995")
                                       d2 (.parse Date "Mon, 25 Dec 1995 00:00:00 GMT")]
                                       (date-equal? d1 d2))))
(.add suite "dictionary-equal?" (fn [] (dictionary-equal? {"one" 1} (dictionary "one" 1))))
(.add suite "vector-equal?" (fn [] (vector-equal? [1 2 3] [1 2 3])))
(.add suite "equivalent?/=" (fn [] (equivalent? [1 2 3 4 5] (list 1 2 3 4 5))))
(.add suite "==" (fn [] (== [1 2 3 4 5] (list 1 2 3 4 5))))
(.add suite ">" (fn [] (> 2 1)))
(.add suite ">=" (fn [] (>= 1 1)))
(.add suite "<" (fn [] (< 1 2)))
(.add suite "<=" (fn [] (<= 1 1)))
(.add suite "+" (fn [] (+ 1 2 3)))
(.add suite "-" (fn [] (- 20 10 10)))
(.add suite "/" (fn [] (/ 50 5 2)))
(.add suite "*" (fn [] (* 2 4 6)))
(.add suite "and" (fn [] (and true 1)))
(.add suite "or" (fn [] (or true false)))
(.add suite "max" (fn [] (max 6 10 2)))
(.add suite "min" (fn [] (min 6 10 2)))

(.on suite "start" (fn [] (print "Starting Wisp runtime benchmarks...\n")))
(.on suite "cycle" (fn [event] (print (String (.-target event)))))
(.on suite "error" (fn [event] (print "ERROR: Could not run benchmark:" (String (.-target event)))))
(.on suite "complete" (fn [] (print "\nDone.")))

(.run suite {"async": true})

