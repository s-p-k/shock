;;;; See the LICENSE file for details
;;;;
;;;; This is a small package that is intended to help users simulate logic
;;;; circuits.


;; define and-gate

(define and-gate
  (lambda (signal)
	  (cond ((list? signal) (and-gate-iter signal))
	  (else (display "error: wrong usage\n")))))

(define and-gate-iter
  (lambda (signal)
    (let ((l (length signal))
	  (result #f))
      (cond ((eq? l 2)
	     (begin (set! result (and (car signal)
				      (cadr signal)))
		    result))
	    (else (begin (- l 1)
			 (set! result (and (car signal)
					   (cadr signal)))
			 (and-gate-iter (cdr signal))))))))
;; define or-gate

(define or-gate
  (lambda (signal)
    (cond ((list? signal) (or-gate-iter signal))
	  (else (display "error: wrong usage\n")))))

(define or-gate-iter
  (lambda (signal)
    (let ((l (length signal))
	  (result #f))
      (cond ((eq? l 2)
	     (begin (set! result (or (car signal)
				     (cadr signal)))
		    result))
	    (else (begin (- l 1)
			 (set! result (or (car signal)
					  (cadr signal)))
			 (or-gate-iter (cdr signal))))))))

;; define not-gate

(define not-gate
  (lambda (signal)
    (not signal)))

;;;; below is a simple circuit to test if the gates defined above work correctly
;;;;
;;;; A _  --- ________ ----     ---         _____
;;;; B - |AND|   _____| OR |---|NOT|-------|     |
;;;;      ---   |      ----     ---     ___| AND |------> OUTPUT
;;;;      --- __|                      |    -----
;;;; C - |AND|            E ------------
;;;; D -  --- 


;; define signal values for testing (everything 0)

(define a-signal #f)
(define b-signal #f)
(define c-signal #f)
(define d-signal #f)
(define e-signal #f)

;; create the circuit drawn above and simulate for the above signal values

(define simulate
  (lambda ()
    (and-gate (list e-signal
		    (not-gate (or-gate (list (and-gate (list a-signal
							     b-signal))
					 (and-gate (list c-signal
							 d-signal)))))))))
