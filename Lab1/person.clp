(deftemplate person
   (slot name)
   (slot age)
   (slot sex))

(deffacts people
   (person (name Ivan) (age 25) (sex male))
   (person (name Berta) (age 30) (sex female))
   (person (name Olena) (age 22) (sex female)))