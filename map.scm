
;;; 6.905 Final Project                                                                                                                                                                                    
;;; Spring 2020                                                                                                                                                                                             
;;; Adventure World Package Manager                                                                                                                                                                         
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Map type definition

(define package-map:places
  (make-property 'places
		 'predicate (lambda (x)
			      (and (n:list? x) (every place?)))
		 'default-value '()))

(define package-map?
  (make-type 'map (list package-map:places)))
(set-predicate<=! package-map? package?)

(define make-map
  (type-instantiator package-map?))

(define get-places
  (property-getter package-map:places package-map?))

(define add-place!
  (property-adder pacakge-map:places package-map? place?)) 
