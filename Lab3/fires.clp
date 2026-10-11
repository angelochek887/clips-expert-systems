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

(defrule class-A
   (declare (salience 10))
   (fire (material ?m&paper|wood|cloth))
   =>
   (assert (fire-class (material ?m) (class A))))

(defrule class-B
   (declare (salience 10))
   (fire (material ?m&oil|gas|grease))
   =>
   (assert (fire-class (material ?m) (class B))))

(defrule class-C
   (declare (salience 10))
   (fire (material ?m&electrical-equipment))
   =>
   (assert (fire-class (material ?m) (class C))))

(defrule class-D
   (declare (salience 10))
   (fire (material ?m&magnesium|sodium|potassium))
   =>
   (assert (fire-class (material ?m) (class D))))

(defrule extinguish-A
   (fire-class (material ?m) (class A))
   =>
   (printout t "Material: " ?m crlf
               "Fire class: A (ordinary combustibles)" crlf
               "Extinguishers: water, water-based liquids, dry chemicals" crlf
               "Action: use heat-absorbing or combustion-retarding agents" crlf crlf))

(defrule extinguish-B
   (fire-class (material ?m) (class B))
   =>
   (printout t "Material: " ?m crlf
               "Fire class: B (flammable liquids and greases)" crlf
               "Extinguishers: dry chemicals, carbon dioxide, foam, bromotrifluoromethane" crlf
               "Action: exclude air, stop combustible vapors, interrupt the chain reaction" crlf crlf))

(defrule extinguish-C
   (fire-class (material ?m) (class C))
   =>
   (printout t "Material: " ?m crlf
               "Fire class: C (energized electrical equipment)" crlf
               "Extinguishers: dry chemicals, carbon dioxide, bromotrifluoromethane" crlf
               "Action: use a nonconducting agent, cut the power if possible" crlf crlf))

(defrule extinguish-D
   (fire-class (material ?m) (class D))
   =>
   (printout t "Material: " ?m crlf
               "Fire class: D (combustible metals)" crlf
               "Extinguishers: trimethoxyboroxine, screened graphitized coke" crlf
               "Action: smother with chemicals that do not react with the burning metal" crlf crlf))

(defrule unknown-material
   (declare (salience -10))
   (fire (material ?m))
   (not (fire-class (material ?m)))
   =>
   (printout t "Material: " ?m crlf
               "Fire class is unknown, check the material name" crlf crlf))