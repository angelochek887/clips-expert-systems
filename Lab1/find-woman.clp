(defrule find-woman
   (person (name $?name) (sex female))
   =>
   (printout t "Woman: " (implode$ ?name) crlf))