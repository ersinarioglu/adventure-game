;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Map type definition

(define package-map:places
  (make-property 'places
		 'predicate (is-list-of object?)
                 'default-value '()))

(define package-map?
  (make-type 'map (list package-map:places)))
(set-predicate<=! package-map? object?)

(define make-package-map
  (type-instantiator package-map?))

(define get-places
  (property-getter package-map:places package-map?))

(define add-place!
  (property-adder package-map:places package-map? object?)) 


