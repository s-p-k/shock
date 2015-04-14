# Description
  shock is a small package to simulate logic gates and circuits. Currently,
  shock supports the following gates for simulation[1]:
  
  - and
  - or
  - nand
  - nor
  - xor
  - xnor

  From circuits, currently only half adder is available.

  shock is written with the chicken[2] Scheme implementation in mind and the
  current version is v0.2.

# Loading shock to your Scheme
  After cloning the repo, you can load shock to your chicken interpreter with:

``` scheme
  > (load "/path/to/shock.scm")
```
  If loading was succesfull, you should see something like this:

``` scheme
  ; loading shock.scm ...
  ; loaded shock-v0.2 successfully.
  ; See LICENSE file for details.
```

# Getting help after loading shock to your interpreter.
  You can also get help on how to use shock by running the two helping
  procedures: shock-help and shock available-gates.

  To list all available gates for simulation run:

  > (shock-available-gates)
  Available gates for simulation:
  and-gate
  or-gate
  nand-gate
  nor-gate

  This means we can call simulate-gate with each of the gates listed above.

  You can also use the shock-help procedure which has a brief description on how
  to use shock.

# Simulating gates - two examples
  To simulate a gate of n inputs, all the user has to do is call simulate-gate
  procedure with the appropriate number of inputs. For instance you can simulate
  a 2-input and gate by running:

  > (simulate-gate and-gate 2)

  and this should return:

  input: (#f #f) -----> #f
  input: (#t #f) -----> #f
  input: (#f #t) -----> #f
  input: (#t #t) -----> #t
  Simulation ended successfully.

  Likewise, to simulate a 3-input nor gate all we have to do is:

  > (simulate-gate nor-gate 3)
  input: (#f #f #f) -----> #t
  input: (#t #f #f) -----> #f
  input: (#f #t #f) -----> #f
  input: (#t #t #f) -----> #f
  input: (#f #f #t) -----> #f
  input: (#t #f #t) -----> #f
  input: (#f #t #t) -----> #f
  input: (#t #t #t) -----> #f
  Simulation ended successfully

# Known bugs

  Currently, n-inputs, the procedure that produces all the possible inputs of a
  n-input gate isn't able to produce them in the logic of binary numbers
  (00, 01, 10, 11 for n = 2). See The inputs for 2-input and-gate on the examples
  above. Please report any bug at mr.dwts <AT> gmail <DOT> com 

Footnotes
_________

[1]: not gate is also available but it makes sense to use it only when
building circuits.
[2]: http://www.call-cc.org/
