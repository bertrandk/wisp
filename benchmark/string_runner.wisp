(ns runtime-runner
	(:require [benchmark :refer [Suite]]
            [wisp.string :refer [split join upper-case lower-case capitalize
                                 replace triml trimr trim blank?]]))

(def suite (Suite.))

;; String functions
(.add suite "split" (fn [] (split "green, eggs, ham" #", " )))
(.add suite "join" (fn [] (join " " [:green :eggs :and :ham])))
(.add suite "upper-case" (fn [] (upper-case "This is a string.")))
(.add suite "lower-case" (fn [] (lower-case "THIS IS A STRING.")))
(.add suite "capitalize" (fn [] (capitalize "tHIS IS A STRING.")))
(.add suite "replace" (fn [] (replace "Hello, name" "name" "John")))
(.add suite "triml" (fn [] (triml "  This is a string.")))
(.add suite "trimr" (fn [] (trimr "This is a string.  ")))
(.add suite "trim" (fn [] (trim "  This is a string.  ")))
(.add suite "blank?" (fn [] (blank? "     ")))

(.on suite "start" (fn [] (print "Starting Wisp runtime benchmarks...\n")))
(.on suite "cycle" (fn [event] (print (String (.-target event)))))
(.on suite "error" (fn [event] (print "ERROR: Could not run benchmark:" (String (.-target event)))))
(.on suite "complete" (fn [] (print "\nDone.")))

(.run suite {"async": true})

