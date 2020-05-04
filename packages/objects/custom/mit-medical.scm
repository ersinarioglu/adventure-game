(define mit-medical-visibility
  (create-package 'mit-medical-visibility
                  '()
                  'mit-medical))
(define mit-medical-movement
  (create-package 'mit-medical-movement
                  '()
                  'mit-medical))
(define mit-medical
  (create-package 'mit-medical
                  (list 'mit-medical-visibility 'mit-medical-movement)
                  '()))
