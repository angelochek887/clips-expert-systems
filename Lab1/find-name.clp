(defrule find-name
   (person (name Berta Ida) (age ?age) (sex ?sex))
   =>
   (printout t "Berta Ida found: age " ?age ", sex " ?sex crlf))