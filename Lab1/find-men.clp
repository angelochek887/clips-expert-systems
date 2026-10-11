(defrule find-men
   (person (name $?name) (sex male))
   =>
   (printout t "Man: " (implode$ ?name) crlf))