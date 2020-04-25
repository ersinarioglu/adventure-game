
;;; 6.905 Final Project                                                                                                                                                                                    
;;; Spring 2020                                                                                                                                                                                             
;;; Adventure World Package Manager                                                                                                                                                                         
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Map type definition

(define package-map:places
  (make-property 'places
		 'predicate (is-list-of place?)
                 'default-value '()))

(define package-map?
  (make-type 'map (list package-map:places)))
(set-predicate<=! package-map? package?)

(define make-package-map
  (type-instantiator package-map?))

(define get-places
  (property-getter package-map:places package-map?))

(define add-place!
  (property-adder pacakge-map:places package-map? place?)) 

(define-generic-procedure-handler install-package!
  (match-args package-map?)
  (lambda (package-map)
    (for-each (lambda (place)
                (manage add (get-name place)))
              (get-places package-map))))
