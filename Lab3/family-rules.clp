(deftemplate relative
   (slot relation (allowed-values father mother parents))
   (slot of)
   (multislot is))

(deftemplate family-role
   (slot name)
   (slot role (allowed-values father mother son daughter)))

(deftemplate gender
   (slot name)
   (slot sex (allowed-values male female)))

(deffacts family
   (relative (relation father) (of John) (is Tom))
   (relative (relation mother) (of John) (is Susan))
   (relative (relation parents) (of John) (is Tom Susan))
   (family-role (name Tom) (role father))
   (family-role (name Susan) (role mother))
   (family-role (name John) (role son))
   (gender (name Tom) (sex male))
   (gender (name Susan) (sex female))
   (gender (name John) (sex male)))

(defrule print-parent
   (declare (salience 30))
   (relative (relation ?rel&father|mother) (of ?child) (is ?parent))
   =>
   (printout t "The " ?rel " of " ?child " is " ?parent "." crlf))

(defrule print-parents
   (declare (salience 30))
   (relative (relation parents) (of ?child) (is ?p1 ?p2))
   =>
   (printout t "The parents of " ?child " are " ?p1 " and " ?p2 "." crlf))

(defrule print-role
   (declare (salience 20))
   (family-role (name ?name) (role ?role))
   =>
   (printout t ?name " is a " ?role "." crlf))

(defrule print-gender
   (declare (salience 10))
   (gender (name ?name) (sex ?sex))
   =>
   (printout t ?name " is a " ?sex "." crlf))