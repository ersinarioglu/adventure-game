;;; 6.905 Final Project                                                                                                                                                                                   
;;; Spring 2020                                                                                                                                                                                            
;;; Adventure World Package Manager                                                                                                                                                                       
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Package type definition
(define package:map
  (make-property 'map
                 'predicate (lambda (x) (container? x))))
(define package:rules
  (make-property 'rules
                 'predicate (lambda (x) (container? x))))
(define package:objects
  (make-property 'objects
                 'predicate (lambda (x) (container? x))))
(define package?
  (make-type 'package (list package:map package:rules package:objects)))
(set-predicate<=! package? container?)

(define get-map
  (property-getter package:map package?))

(define set-map
  (property-setter package:map pacakge? container?))

(define get-rules
  (property-getter package:rules package?))

(define set-rules
  (property-setter package:rules package? container?))

(define get-objects
  (property-getter package:objects package?))

(define set-objects
  (property-setter package:objects package? container?))

;;; generic procedure handlers?
