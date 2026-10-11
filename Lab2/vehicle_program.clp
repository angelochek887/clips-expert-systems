(deftemplate MAIN::vehicle
   (slot name)
   (slot type)
   (slot max-speed-kmh (type INTEGER) (range 0 ?VARIABLE))
   (slot passengers (type INTEGER) (range 1 ?VARIABLE))
   (slot fuel (allowed-values petrol none aviation-kerosene)))

(deffacts MAIN::vehicles
   (vehicle (name car) (type passenger) (max-speed-kmh 220) (passengers 5) (fuel petrol))
   (vehicle (name bicycle) (type two-wheeled) (max-speed-kmh 30) (passengers 1) (fuel none))
   (vehicle (name airplane) (type jet) (max-speed-kmh 900) (passengers 150) (fuel aviation-kerosene)))

(defrule MAIN::fast-vehicle
   (vehicle (name ?name) (max-speed-kmh ?speed&:(> ?speed 100)))
   =>
   (printout t "Fast vehicle: " ?name ", max speed " ?speed " km/h" crlf))

(defrule MAIN::no-fuel-vehicle
   (vehicle (name ?name) (fuel none))
   =>
   (printout t "Vehicle without fuel: " ?name crlf))

