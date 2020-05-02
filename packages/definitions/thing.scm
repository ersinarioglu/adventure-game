;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Thing type
(define thing:location
  (make-property 'location
                 'predicate (lambda (x) (container? x))))

(define thing?
  (make-type 'thing (list thing:location)))
(set-predicate<=! thing? object?)

(define make-thing
  (type-instantiator thing?))

(define get-location
  (property-getter thing:location thing?))

(define-generic-procedure-handler set-up! (match-args thing?)
  (lambda (super thing)
    (super thing)
    (add-thing! (get-location thing) thing)))

(define-generic-procedure-handler tear-down! (match-args thing?)
  (lambda (super thing)
    (remove-thing! (get-location thing) thing)
    (super thing)))

(define-generic-procedure-handler send-message!
  (match-args message? thing?)
  (lambda (message thing)
    #f))


;;; Handler for build method
(define (create-thing args)
  (let ((name (first args))
	(location (second args)))
    (make-thing 'name name
		'location location)))

(add-build-handler 'thing create-thing)
