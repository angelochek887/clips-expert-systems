(deffacts MAIN::test-facts
   (hello world))

(defrule MAIN::hello-rule
   (hello world)
   =>
   (printout t "Hello, CLIPS!" crlf))

