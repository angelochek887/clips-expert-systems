(deftemplate fire
   (slot material))

(deftemplate fire-class
   (slot material)
   (slot class (allowed-values A B C D)))

(deffacts burning-materials
   (fire (material wood))
   (fire (material oil))
   (fire (material electrical-equipment))
   (fire (material magnesium)))

(deffunction get-fire-class (?m)
   (if (member$ ?m (create$ paper wood cloth)) then (return A))
   (if (member$ ?m (create$ oil gas grease)) then (return B))
   (if (member$ ?m (create$ electrical-equipment)) then (return C))
   (if (member$ ?m (create$ magnesium sodium potassium)) then (return D))
   unknown)

(deffunction get-description (?class)
   (switch ?class
      (case A then "ordinary combustibles")
      (case B then "flammable liquids and greases")
      (case C then "energized electrical equipment")
      (case D then "combustible metals")
      (default "unknown")))

(deffunction get-extinguishers (?class)
   (switch ?class
      (case A then "water, water-based liquids, dry chemicals")
      (case B then "dry chemicals, carbon dioxide, foam, bromotrifluoromethane")
      (case C then "dry chemicals, carbon dioxide, bromotrifluoromethane")
      (case D then "trimethoxyboroxine, screened graphitized coke")
      (default "unknown")))

(deffunction get-action (?class)
   (switch ?class
      (case A then "use heat-absorbing or combustion-retarding agents")
      (case B then "exclude air, stop combustible vapors, interrupt the chain reaction")
      (case C then "use a nonconducting agent, cut the power if possible")
      (case D then "smother with chemicals that do not react with the burning metal")
      (default "unknown")))

(deffunction print-recommendation (?m ?class)
   (printout t "Material: " ?m crlf
               "Fire class: " ?class " (" (get-description ?class) ")" crlf
               "Extinguishers: " (get-extinguishers ?class) crlf
               "Action: " (get-action ?class) crlf crlf))

(deffunction check-materials ($?materials)
   (printout t "Materials checked: " (length$ ?materials) crlf)
   (foreach ?m ?materials
      (printout t ?m " -> class " (get-fire-class ?m) crlf)))

(defrule classify-fire
   (declare (salience 10))
   (fire (material ?m))
   (test (neq (get-fire-class ?m) unknown))
   =>
   (assert (fire-class (material ?m) (class (get-fire-class ?m)))))

(defrule recommend-extinguisher
   (fire-class (material ?m) (class ?class))
   =>
   (print-recommendation ?m ?class))

(defrule unknown-material
   (declare (salience -10))
   (fire (material ?m))
   (test (eq (get-fire-class ?m) unknown))
   =>
   (printout t "Material: " ?m crlf
               "Fire class is unknown, check the material name" crlf crlf))