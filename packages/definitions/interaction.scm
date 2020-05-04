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
