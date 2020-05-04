;;; Aware Things

; Things that are "aware" of other things (have refs to them)
(define aware-thing:instances
  (make-property 'instances
		 'predicate (is-list-of thing?)
		 'default-value '()))

; type creation
(define aware-thing?
  (make-type 'aware-thing (list aware-thing:instances)))
(set-predicate<=! aware-thing? thing?)

; constructor
(define make-aware-thing
  (type-instantiator aware-thing?))

; get the instances aware of
(define get-instances
  (property-getter aware-thing:instances aware-thing?))

; set the instances aware of
(define set-instances
  (property-setter aware-thing:instances
		   aware-thing?
		   (is-list-of thing?)))
