(defrule fast-vehicle
 (vehicle (name ?name) (max-speed-kmh ?speed&:(> ?speed 100)))
 =>
 (printout t "Fast vehicle: " ?name ", max speed " ?speed " km/h" crlf))

(defrule no-fuel-vehicle
 (vehicle (name ?name) (fuel none))
 =>
 (printout t "Vehicle without fuel: " ?name crlf))