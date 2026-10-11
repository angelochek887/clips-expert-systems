(defrule find-age
   (person (name $?name) (age 25))
   =>
   (printout t "Person aged 25: " (implode$ ?name) crlf))