;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

#|
Divide package objects into their own file - package definitions file and package object file are separate. Upon starting manager, the package object files are loaded. Upon starting an adventure, the package definitions files needed are loaded based on the package object files and their children 
Install-package command modifies tree that specifies the definitions files that will be loaded upon start-adventure
Start-adventure will create a new environment, load the definitions files into that environment, and switch the repl to that game environment |#

;;; ANALYSIS

(define summarize-file ; filename environment
  (lexical-reference (manage 'manager-environment) 'summarize-file))


(define (summary-file summary) (cadr (assq 'filename summary)))
(define (summary-free summary) (cadr (assq 'free summary)))
(define (summary-bound summary) (cadr (assq 'bound summary)))

(define (make-by-name-index summaries)
  (let ((index (make-strong-eq-hash-table)))
    (for-each (lambda (summary)
		(let ((file (summary-file summary))
		      (bindings (summary-bound summary)))
		  (for-each (lambda (binding)
			      (hash-table-update!/default
			       index
			       binding
			       (lambda (definers)
				 (cons file definers))
			       (list file))
			      bindings))))
	      summaries)))

(define (conflicts by-name-index)
  (filter (lambda (name-definers-pair)
	    (> (length (cdr name-definers-pair)) 1))
	  (hash-table->alist by-name-index)))

(let ((here (directory-pathname (current-load-pathname))))
  (for-each (lambda (package-object-pathname)
	      (load (->namestring package-object-pathname)))
	    (filter (lambda (pn)
		      (not (string-prefix? "." (pathname-name pn))))
	     (directory-read (->namestring
			      (merge-pathnames
			       (->pathname "packages/objects/custom/")
			       here))))))


;;; Building default package

(define (create-package name things-to-build children)
  (make-package 'name name
                'things-to-build things-to-build
                'children children))

(define default-package
  (create-package 'default-package
                  '()
                  (list root)))


;;; BUILD

(define build
  (simple-generic-procedure 'build 1
			    (lambda args (error "unknown object to build:" args))))

(define (tagged-list? tag)
  (lambda (x)
    (and (list? x)
	 (> (length x) 0)
	 (eq? tag (first x)))))

(define (add-build-handler tag handler)
  (define-generic-procedure-handler build
    (match-args (tagged-list? tag))
    (lambda (lst)
      (apply handler (cdr lst)))))




(define (build-package package environment)
  (let ((things-to-build (get-things-to-build package))
	(children (get-children package))
	(build-method (get-build-method package)))
    (append (build-method-package things-to-build environment)
	    (reduce-left append '() (map build-package children)))))



;;; THESE DEFINE A TREE DATA TYPE

(define (empty-tree)
  (list))

(define (new-tree-with-root name)
  (list name))


;; Gets the value of the root node in the tree.
(define (tree:get-root tree)
  (car tree))

;; Gets the sub trees of the tree
(define (tree:get-sub-trees tree)
  (cdr tree))

;; Gets the child nodes of the root node of a tree
(define (tree:get-children tree)
  (map tree:get-root (tree:get-sub-trees tree)))


;; Finds a subtree within "tree" that has root that satisfies "predicate".
(define (tree:find-tree-with-root tree predicate)
  (define result #f)
  (define (find-tree-with-root-helper tree)
    ;(display (tree:get-sub-trees tree))
    (if (eq? tree (empty-tree))
	#f
	(if (predicate (tree:get-root tree))
	    (set! result tree)
	    (map find-tree-with-root-helper (tree:get-sub-trees tree)))))
  (find-tree-with-root-helper tree)
  result)



;; Adds given "new-tree" under node in "tree" that satisfies "predicate".
(define (tree:add-tree-to-place! tree predicate new-tree)
  (let ((sub-tree (tree:find-tree-with-root tree predicate)))
    (if subtree
	(append! sub-tree (list new-tree))
	#f)))

;; Adds given "object" as a node under a node that satisfies "predicate" in "tree"
(define (tree:add-object-to-place! tree predicate object)
  (tree:add-tree-to-place! tree predicate (list object)))


;;; NOW WE ADD UTILITIES FOR PACKAGES:

;; Finds package in list of "packages" that has "name"
(define (find-package-in-list packages name)
  (find (lambda (package)
	  (eq? name (get-name package))) packages))

(define (find-root-package packages)
  (find-package-in-list packages 'root))

;; Finds subtree in "tree" that has root package that has name "package-name"
(define (get-subtree-with-root-package tree package-name)
  (tree:find-tree-with-root tree (lambda (package)
				   (eq? (get-name package) package-name))))

(define (add-object-to-subtree-with-root-package! tree root-package-name
					   object)
  (tree:add-object-to-place! tree (lambda (package)
				    (eq? (get-name package) root-package-name))
			     object))

(define (add-list-of-packages-to-subtree! tree root-package-name objects)
  (define (helper object)
    (add-object-to-subtree-with-root-package! tree root-package-name object))
  (map helper objects))
	 
;; packages is a list of packages

(define (make-tree-from-packages packages)
  (define my-tree (list (get-root-package packages)))

  ;; Adds the children of a given "package" to "tree" if "package" is in "tree"
  (define (populate-children tree package)
    (add-list-of-packages-to-subtree! tree (get-name package)
				      (get-children package)))

  (define (populate-children-my-tree package)
    (populate-children my-tree package))
 
  (let loop ((leaves (list (get-root-package packages))))
    (map populate-children-my-tree leaves)
    (let ((new-leaves (map get-children leaves)))
      (if (> (length new-leaves 0))
	  (loop new-leaves)))))


  
    
    








(define my-tree (list 'world (list 'france
				   (list 'paris))
		      (list 'spain
			    (list 'madrid))
			    
		      (list 'turkey
			    (list 'ankara))))


  
;;; list packages must return packages in depth first order!
(define (list-packages)
  ())

(define (find-package-by-name package-name)
  (find (lambda (package)
	  (eq? (get-name package) package-name)) all-packages))

(define (install-package! point-of-install new-package)
  (let ((parent (find-package-by-name point-of-install))
        (child (find-package-by-name new-package)))
    (cond ((and parent child) (add-child! parent child)
                  (display "\nInstallation successful."))
          ((and parent (not child)) (display "\nOops, the package you're trying to install doesn't exist."))
          ((and (not parent) child) (display "\nOops, the point of installation doesn't exist- try listing the packages to see which packages are currently installed."))
          (else (display "\nNeither of those packages exist."))
          )))

(define (uninstall-package! package-name) () )

;;; GAME STATE

#|
use environment-define to assign values built by 
build to symbols in the game environment
|#

(define build-game
  ())

(define build-people
  ())

(define clock)
(define all-places)
(define heaven)
(define all-people)
(define my-avatar)

(define (lowlevel-start-adventure name)
  (set! clock (make-clock))
  (set! all-places (build-game))
  (set! heaven (create-place 'heaven))
  (set! all-people (build-people all-places))
  (set! my-avatar
        (create-avatar name
                       (random-choice all-places)))
  (whats-here))
        
         
(define (start-adventure name)
  (let* ((packages (list-packages))
         (game-env (make-environment
		     (map (lambda (package)
			    (load (string-append
				   "packages/objects/"
				   (symbol->string (get-name package))))
			    packages)))))
    (build-package (tree:get-root package-tree) game-env)
    (ge game-env)
    (lowlevel-start-adventure name)))


(define (get-all-places)
  all-places)

(define (get-heaven)
  heaven)

(define (get-clock)
  the-clock)

;;; Game UI functions

(define (go direction)
  (let ((exit
         (find-exit-in-direction direction
                                 (get-location my-avatar))))
    (if exit
        (take-exit! exit my-avatar)
        (narrate! (list "No exit in" direction "direction")
                  my-avatar)))
  'done)

(define (take-thing name)
  (let ((thing (find-thing name (here))))
    (if thing
        (take-thing! thing my-avatar)))
  'done)

(define (drop-thing name)
  (let ((thing (find-thing name my-avatar)))
    (if thing
        (drop-thing! thing my-avatar)))
'done)

(define (look-in-bag #!optional person-name)
  (let ((person
         (if (default-object? person-name)
             my-avatar
             (find-person person-name))))
    (if person
        (tell! (let ((referent (local-possessive person))
                     (things (get-things person)))
                 (if (n:pair? things)
                     (cons* referent "bag contains" things)
                     (list referent "bag is empty")))
               my-avatar)))
  'done)

(define (whats-here)
  (look-around my-avatar)
  'done)

(define (say . message)
  (say! my-avatar message)
  'done)

(define (tell person-name . message)
  (tell! message (find-person person-name))
  'done)

(define (hang-out ticks)
  (do ((i 0 (n:+ i 1)))
      ((not (n:< i ticks)))
    (tick! (get-clock)))
  'done)

;;; Game UI support

(define (here)
  (get-location my-avatar))

(define (find-person name)
  (let ((person
         (find-object-by-name name (people-here my-avatar))))
    (if (not person)
        (tell! (list "There is no one called" name "here")
               my-avatar))
    person))

(define (find-thing name person-or-place)
  (let ((thing
         (find-object-by-name
          name
          (person-or-place-things person-or-place))))
    (if (not thing)
        (tell! (cons* "There is nothing called"
                      name
                      (person-or-place-name person-or-place))
               my-avatar))
    thing))

(define (person-or-place-things person-or-place)
  (if (place? person-or-place)
      (all-things-in-place person-or-place)
      (get-things person-or-place)))

(define (person-or-place-name person-or-place)
  (if (place? person-or-place)
      '("here")
      (list "in" (local-possessive person-or-place) "bag")))

(define (local-possessive person)
  (if (eqv? person my-avatar)
      "Your"
      (possessive person)))



;;; UI ANNOUNCEMENT

(newline)
(display "Welcome to the adventure game package manager!\n")
(display "Here's a few commands to get you started:\n\n")
(display  "---------------------------------------------------------------\n\n")
(display  "'list-packages' : returns the names of all currently installed packages\n\n")
(display  "'install-package! [parent-package] [new-package]' : \ninstalls new packages as children of parent package\n\n")
(display "'uninstall-package! [package]' : \nuninstalls package and all of the package's children, if it exists and is currently installed\n\n") 
(display "'start-adventure [your-name]' : begins an adventure in a world with all currently installed packages")
