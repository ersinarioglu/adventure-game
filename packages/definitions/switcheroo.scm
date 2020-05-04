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

;;; Interaction

; generic procedure
(define generic-interact!
  (most-specific-generic-procedure 'generic-interact! 2 #f))

; uninteractable
(define-generic-procedure-handler generic-interact!
  (match-args thing? person?)
  (lambda (thing person)
    (tell! (list thing "doesn't seem to have a function.")
	   person)))

; using things by the avatar
(define (use-thing name)
  (let ((thing (find-thing name (here))))
    (if thing
	(generic-interact! thing my-avatar)))
  'done)

;;; Switcheroo Button

(define switcheroo-button:failure
  (make-property 'failure
		 'predicate bias?
		 'default-value 1))

; make a button type
(define switcheroo-button?
  (make-type 'switcheroo-button (list switcheroo-button:failure)))
(set-predicate<=! switcheroo-button? aware-thing?)
(set-predicate<=! switcheroo-button? mobile-thing?)

; make a button
(define make-switcheroo-button
  (type-instantiator switcheroo-button?))

; find out its failure probability
(define get-failure
  (property-getter switcheroo-button:failure switcheroo-button?))

(define (get-switcheroo-instance button)
  (assert (switcheroo-button? button))
  (car (get-instances button)))

(define (set-switcheroo-instance button instance)
  (assert (switcheroo-button? button))
  (assert (thing? instance))
  (set-instances button (list instance)))

; switcheroo
(define-generic-procedure-handler generic-interact!
  (match-args switcheroo-button? person?)
  (lambda (button person)
    (if (flip-coin (get-failure button))
	(generic-teleport! person
			   (get-switcheroo-instance button))
	(begin
	  (narrate! (list button "begins to smoke") person)
	  (die! person)))))

(define generic-teleport!
  (most-specific-generic-procedure 'generic-teleport! 2 #f))

(define-generic-procedure-handler generic-teleport!
  (match-args person? mobile-thing?)
  (lambda (person mobile)
    (let ((loc-of-mobile (get-location mobile)))
	  (if (bag? loc-of-mobile)
	      (generic-teleport! person (get-holder loc-of-mobile))
	      (begin
		(narrate! (list person "begins to glow") person)
		(narrate! (list mobile "begins to glow") loc-of-mobile)
		(teleport-internal! (get-location person) person
				    loc-of-mobile mobile))))))

(define-generic-procedure-handler generic-teleport!
  (match-args person? person?)
  (lambda (person-1 person-2)
    (narrate! (list person-1 "begins to glow") person-1)
    (narrate! (list person-1 "begins to glow") person-2)
    (teleport-internal! (get-location person-1) person-1
			(get-location person-2) person-2)))

(define (teleport-internal! from mobile-1 to mobile-2)
  (leave-place! mobile-1)
  (leave-place! mobile-2)
  (remove-thing! from mobile-1)
  (remove-thing! to mobile-2)
  (set-location! mobile-1 to)
  (set-location! mobile-2 from)
  (add-thing! to mobile-1)
  (add-thing! from mobile-2)
  (enter-place! mobile-1)
  (enter-place! mobile-2))

(define (create-switcheroo-button name)
  (make-switcheroo-button 'name name
			  'location (random-choice all-places)
			  'instances '()
			  'failure (random-bias 5)))


(add-build-handler 'switcheroo-button create-switcheroo-button)
