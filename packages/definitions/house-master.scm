;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz


(define house-master:irritability
  (make-property 'irritability
                 'predicate bias?))

(define house-master?
  (make-type 'house-master (list house-master:irritability)))
(set-predicate<=! house-master? autonomous-agent?)

(define make-house-master
  (type-instantiator house-master?))

(define get-irritability
  (property-getter house-master:irritability house-master?))

(define (irritate-students! master)
  (let ((students (filter student? (people-here master))))
    (if (flip-coin (get-irritability master))
        (if (n:pair? students)
            (begin
              (say! master
                    '("What are you doing still up?"
                      "Everyone back to their rooms!"))
              (for-each (lambda (student)
                          (narrate! (list student "goes home to"
                                          (get-origin student))
                                    student)
                          (move! student
                                 (get-origin student)
                                 student))
                        students))
            (say! master
                  '("Grrr... When I catch those students...")))
        (if (n:pair? students)
            (say! master
                  '("I'll let you off this once..."))))))

(define-clock-handler house-master? irritate-students!)

;;; Handler for build method

(define (create-house-master name)
  (make-house-master 'name name
                     'location (random-choice all-places)
                     'restlessness (random-bias 3)
                     'acquisitiveness 1/10
                     'irritability (random-bias 3)))
