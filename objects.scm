;;; 6.905 Final Project                                                                                                                                                                                    
;;; Spring 2020                                                                                                                                                                                           
;;; Adventure World Package Manager                                                                                                                                                                       
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Object type definition

(define package-objects:objects
  (make-property 'objects
                 'predicate (is-list-of thing?)
                 'default-value '()))
(define package-objects?
  (make-type 'package-objects (list package-objects:objects)))
(set-predicate<=! package-objects? container?)

(define make-package-objects
  (type-instantiator package-objects?))

(define get-objects
  (property-getter package-objects:objects package-object?))

(define add-object!
  (property-adder package-objects:objects package-object? thing?))

(define remove-object!
  (property-remover package:objects:objects package-object? thing?))

;;; Things and containers from original Adventure Game                   
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

;;; Containers

(define container:things
  (make-property 'things
                 'predicate (is-list-of thing?)
                 'default-value '()))

(define container?
  (make-type 'container (list container:things)))
(set-predicate<=! container? object?)

(define get-things
  (property-getter container:things container?))

(define add-thing!
  (property-adder container:things container? thing?))

(define remove-thing!
  (property-remover container:things container? thing?))
