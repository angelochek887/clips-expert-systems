(deftemplate MAIN::binary-#
   (multislot name)
   (multislot digits))

(deftemplate MAIN::add-binary-#s
   (slot name-1)
   (slot name-2))

(deftemplate MAIN::addition
   (multislot name)
   (multislot digits-1)
   (multislot digits-2)
   (slot carry)
   (multislot result))

(deftemplate MAIN::bit-sum
   (slot a)
   (slot b)
   (slot carry-in)
   (slot sum)
   (slot carry-out))

(deffacts MAIN::bit-sum-table
   (bit-sum (a 0) (b 0) (carry-in 0) (sum 0) (carry-out 0))
   (bit-sum (a 0) (b 1) (carry-in 0) (sum 1) (carry-out 0))
   (bit-sum (a 1) (b 0) (carry-in 0) (sum 1) (carry-out 0))
   (bit-sum (a 1) (b 1) (carry-in 0) (sum 0) (carry-out 1))
   (bit-sum (a 0) (b 0) (carry-in 1) (sum 1) (carry-out 0))
   (bit-sum (a 0) (b 1) (carry-in 1) (sum 0) (carry-out 1))
   (bit-sum (a 1) (b 0) (carry-in 1) (sum 0) (carry-out 1))
   (bit-sum (a 1) (b 1) (carry-in 1) (sum 1) (carry-out 1)))

(deffacts MAIN::test-numbers
   (binary-# (name A) (digits 1 0 1 1 1))
   (binary-# (name B) (digits 1 1 1 0))
   (add-binary-#s (name-1 A) (name-2 B)))

(defrule MAIN::start-addition
   ?f <- (add-binary-#s (name-1 ?n1) (name-2 ?n2))
   (binary-# (name ?n1) (digits $?d1))
   (binary-# (name ?n2) (digits $?d2))
   =>
   (retract ?f)
   (assert (addition (name ?n1 + ?n2) (digits-1 $?d1) (digits-2 $?d2) (carry 0) (result))))

(defrule MAIN::pad-first
   ?a <- (addition (digits-1) (digits-2 ? $?))
   =>
   (modify ?a (digits-1 0)))

(defrule MAIN::pad-second
   ?a <- (addition (digits-1 ? $?) (digits-2))
   =>
   (modify ?a (digits-2 0)))

(defrule MAIN::add-bits
   ?a <- (addition (digits-1 $?r1 ?x) (digits-2 $?r2 ?y) (carry ?c) (result $?res))
   (bit-sum (a ?x) (b ?y) (carry-in ?c) (sum ?s) (carry-out ?co))
   =>
   (modify ?a (digits-1 $?r1) (digits-2 $?r2) (carry ?co) (result ?s $?res)))

(defrule MAIN::finish-with-carry
   ?a <- (addition (name $?n) (digits-1) (digits-2) (carry 1) (result $?res))
   =>
   (retract ?a)
   (assert (binary-# (name $?n) (digits 1 $?res)))
   (printout t "(" (implode$ $?n) ") = " (implode$ (create$ 1 $?res)) crlf))

(defrule MAIN::finish-without-carry
   ?a <- (addition (name $?n) (digits-1) (digits-2) (carry 0) (result $?res))
   =>
   (retract ?a)
   (assert (binary-# (name $?n) (digits $?res)))
   (printout t "(" (implode$ $?n) ") = " (implode$ $?res) crlf))

