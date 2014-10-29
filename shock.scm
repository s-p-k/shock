;;;; See the LICENSE file for details
;;;;
;;;; This is a small package that is intended to help users simulate logic
;;;; circuits.

;; Our logic alphabet

(define alphabet (list #f #t))

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

;; (define a-signal #f)
;; (define b-signal #f)
;; (define c-signal #f)
;; (define d-signal #f)
;; (define e-signal #f)

;; create the circuit drawn above and simulate for the above signal values

;; (define simulate
;;   (lambda ()
;;     (and-gate (list e-signal
;; 		    (not-gate (or-gate (list (and-gate (list a-signal
;; 							     b-signal))
;; 					 (and-gate (list c-signal
;; 							 d-signal)))))))))

;; return the number of possible combinations given a list and a number n

(define possible-combinations
  (lambda (n lst)
    (expt (length lst)
	  n)))

(define append-element
  (lambda (ele lst)
    (append lst (cons ele
		      '()))))

;; return a n-length list of #t of #f

(define list-of-bits
  (lambda (n bit)
    (list-of-bits-iter n bit '())))

(define list-of-bits-iter
  (lambda (n bit lst)
    (cond ((eq? n 0) lst)
	  (else (begin (set! lst (append-element bit lst))
		       (list-of-bits-iter (- n 1) bit lst))))))

;; produce combinations for our logic alphabet

(define produce-list
  (lambda (lst element)
    (produce-list-iter lst element '())))

(define produce-list-iter
  (lambda (lst element result)
    (cond ((null? lst) result)
	  (else (begin (set! result (append-element (list (car lst)
							  element)
						    result))
		       (produce-list-iter (cdr lst) element result))))))

;; Convert list of lists to a single list

(define flatten-list
  (lambda (lst)
    (cond ((null? lst) '())
	((not (list? lst)) (list lst))
	(else (apply append (map flatten-list lst))))))

;; prepend element to a list

(define prepend-element
  (lambda (lst ele)
    (cond ((null? lst) '())
	  (else (cons ele
		      lst)))))

;; create a list with all the possible combinations of 2- and 3-input

(define 2-inputs
  (lambda ()
    (append (produce-list alphabet #f)
	    (produce-list alphabet #t))))

(define 3-inputs
  (lambda ()
    (map flatten-list (append (produce-list (2-inputs) #f)
			      (produce-list (2-inputs) #t)))))


;; n inputs is the generic form of 2-inputs and 3-inputs

(define n-inputs
  (lambda (n)
    (cond ((eq? n 2) (2-inputs))
	  (else (map flatten-list (append (produce-list (n-inputs (- n 1)) #f)
					  (produce-list (n-inputs (- n 1)) #t)))))))

;; pretty-print all elements of a list

(define pretty-print
  (lambda (lst)
    (if (not (null? lst))
	(begin (display (car lst))
	       (newline)
	       (pretty-print (cdr lst))))))

;; simulate gate currently shows only the output, it should be showing the
;; input too.

;; (define simulate-gate
;;   (lambda (gate n) ; n i number of inputs
;;     (map gate (n-inputs n)))) ; n-inputs is the generic form of 2-inputs.
	  
