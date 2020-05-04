;;; 6.905 Final Project                                                                    
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Messaging

(define send-message!
  (most-specific-generic-procedure 'send-message! 2 #f))

(define (narrate! message person-or-place)
  (send-message! message
                 (if (person? person-or-place)
                     (get-location person-or-place)
                     person-or-place))
  (if debug-output
      (send-message! message debug-output)))

(define (tell! message person)
  (send-message! message person)
  (if debug-output
      (send-message! message debug-output)))

(define (say! person message)
  (narrate! (append (list person "says:") message)
            person))

(define (announce! message)
  (for-each (lambda (place)
              (send-message! message place))
            (get-all-places))
  (if debug-output
      (send-message! message debug-output)))

(define debug-output #f)

(define (enable-debugging)
  (if (not debug-output)
      (set! debug-output (make-screen 'name 'debug))))

(define (disable-debugging)
  (if debug-output
      (set! debug-output #f)))

(define (display-message message port)
  (guarantee message? message 'display-message)
  (if (pair? message)
      (begin
        (fresh-line port)
        (display-item (car message) port)
        (for-each (lambda (item)
                    (display " " port)
                    (display-item item port))
                  (cdr message)))))

(define (display-item item port)
  (display (if (object? item) (get-name item) item) port))

(define (message? object)
  (n:list? object))
(register-predicate! message? 'message)

(define (possessive person)
  (string-append (display-to-string (get-name person))
                 "'s"))

;;; Screen

(define screen:port
  (make-property 'port
                 'predicate output-port?
                 'default-supplier current-output-port))

(define screen?
  (make-type 'screen (list screen:port)))
(set-predicate<=! screen? object?)

(define make-screen
  (type-instantiator screen?))

(define get-port
  (property-getter screen:port screen?))

(define-generic-procedure-handler send-message!
  (match-args message? screen?)
  (lambda (message screen)
    (display-message message (get-port screen))))
