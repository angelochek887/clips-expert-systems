(deftemplate person
   (multislot name)
   (slot age (type INTEGER))
   (slot sex (allowed-values male female)))

(deffacts people
   (person (name Ivan Petrenko) (age 25) (sex male))
   (person (name Berta Ida) (age 30) (sex female))
   (person (name Olena Koval) (age 22) (sex female)))