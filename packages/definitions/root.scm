;;; 6.905 Final Project                                                                    
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; useful things for building children
(define the-clock)
(define all-places)
(define heaven)
(define all-people)
(define my-avatar)

(define (low-level-start-adventure my-name)
  (set! the-clock (make-clock)))

(define (get-all-places)
  all-places)

(define (get-heaven)
  heaven)

(define (get-clock)
  the-clock)

;;; default handler, read and build children
