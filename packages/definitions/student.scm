;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define student?
  (make-type 'student '()))
(set-predicate<=! student? autonomous-agent?)

(define make-student
  (type-instantiator student?))

;;; Handler for build method
(define (create-student args)
  (let ((name (first args)))
    (make-student 'name name
		  'location (random-choice all-places)
		  'restlessness (random-bias 5)
		  'acquisitiveness (random-bias 5))))

(add-build-handler 'student create-student)
