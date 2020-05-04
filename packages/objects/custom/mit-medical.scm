(define mit-medical-visibility
  (create-package 'mit-medical-visibility
                  '()
                  '()))
(define mit-medical-movement
  (create-package 'mit-medical-movement
                  '()
                  '()))
(define mit-medical
  (create-package 'mit-medical
                  (list 'mit-medical-visibility 'mit-medical-movement)
                  '()))
