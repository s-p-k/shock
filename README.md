shock
=====

A small package to simulate logic gates/circuits.

Simulating gates
================

Currently the procedures in the shock package take as input a list an return a list


shock currently can simulate the and, or and not gates. You can simulate the output with
something like:

#;1> (and-gate (list #t #f)) ; pass as input to the and gate #t #f.
#f

You can simulate all the possible combinations of a 2-input and gate and take the
results in a list:

#;2> (map and-gate (2-inputs))
(#f #f #f #t)

For a 3-input gate one can use likewise the 3-inputs procedure:

(map or-gate (3-inputs))

#;3> (map or-gate (3-inputs))
(#f #f #t #t #t #t #t #t)

For gates with 4 or more inputs one can use n-inputs procedure:

#;4> (map or-gate (n-inputs 4))
(#f #f #f #f #t #t #t #t #t #t #t #t #t #t #t #t)

You can also use the pretty-print procedure to make - as the name says - the
output prettier[1]:

#;5> (pretty-print (map and-gate (n-inputs 4)))
#f
#f
#f
#f
#f
#f
#f
#f
#f
#f
#f
#f
#t
#t
#t
#t

[1] pretty-print should make also print the input for every output. This is going to be
fixed soon.



