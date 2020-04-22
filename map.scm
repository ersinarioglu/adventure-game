;;; 6.905 Final Project                                                                                                                                                                                    
;;; Spring 2020                                                                                                                                                                                             
;;; Adventure World Package Manager                                                                                                                                                                         
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Map type definition

(define map:places
  (make-property 'places
		 'predicate (lambda (x)
			      (and (n:list? x) (every place?)))
		 'default-value '()))


(define map?
  (make-type 'map (list map:places)))

(define make-map
  (type-instantiator map?))

(define get-places
  (property-getter map:places map?))

(define add-place!
  (property-adder map:places map? place?)) 
