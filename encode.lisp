;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(defun lisp-to-r (x)
  (etypecase x
    (boolean (lisp-to-r (vector x))) ;; has to be before symbol
    (symbol (let ((name (symbol-name x))) ;; was using string-downcase
	      (if (sexp-unboundp (r%-variable name))
		  (r%-symbol name)
		(r%-variable name))))
    (r-pointer (pointer x))
    #-ALLEGRO
    (cffi-sys:foreign-pointer x)
    (number (lisp-to-r (vector x)))
    (string (new-string-single x))
    ((or list vector)
     (cond ((every (lambda (x) (typep x 'boolean)) x)
	    (let ((result (new-logical (length x))))
	      (set-data-integers result (map 'vector (lambda (x) (if x 1 0)) x))
	      result))
	   ((every #'r-obj-p x)
	    (let ((result (new-real (length x)))) 
	      ;; FIXME, this is completely wrong
	      ;; from the rpy example I'm trying to convert to an R object
	      ;; a list of (0.01231d0), each element is a uni-element vector
	      ;; the line below handles that very specific case
	      (set-data-sexps result (mapcar (lambda (x) (first (get-data-sexps (pointer x)))) x))
	      result))
	   #-ALLEGRO
	   ((every #'cffi-sys:pointerp x) ;; untested
	    (let ((result (new-real (length x))))
	      (set-data-sexps result (mapcar (lambda (x) (first (get-data-sexps x))) x))
	      result))
	   ((every #'integerp x)
	    (let ((result (new-integer (length x))))
	      (set-data-integers result x)
	      result))
	   ((every #'numberp x)
	    (let ((result (new-real (length x))))
	      (set-data-reals result x)
	      result))
	   ((every #'stringp x)
	    (let ((result (new-string (length x))))
	      (set-data-strings result x)
	      result))
	   (t (pointer (apply #'r% "list" (mapcar #'lisp-to-r x))))))))
    


