(in-package :rcl)

#|

;; loading rcl will automatically load the library
;; some functions are available without the need of calling r-init
;; FIXME: RNG functions like (exp-rand) require initialization

(rf-beta 2d0 3d0)

;; start the interpreter by calling
(r-init)

;; to check it works evaluate for example 
(r "license")
;; (license information will be printed) 

;; r% = r-funcall & return R object
;; r  = r-funcall & return lisp object
;; in both cases the output and messages are redirected 

;; (r% "print" (r% "summary" '(3 21 12 31 9 17 25 29 5 14)))

;; (r "print" (r-variable "pressure"))

|#

(defun plot-cl.net-example (&optional (path #+cffi-features:windows "C:/" 
                                            #-cffi-features:windows "/tmp/"))
  (flet ((list-symbols (&optional package &aux symbols)
	   (mapcar #'symbol-name (if package 
				     (do-symbols (s package symbols) (push s symbols))
				     (do-all-symbols (s symbols) (push s symbols)))))) 
    (let ((lengths-cl (mapcar #'length (list-symbols "CL")))
	  (lengths-all (mapcar #'length (list-symbols))))
      (with-device ((format nil "~A/symbol-length" path) :pdf)
	(r-funcall "hist" lengths-cl :breaks "scott"
		   :ylab "number" :xlab "symbol length" :main "symbols in COMMON-LISP")
	(r-funcall "hist" lengths-all :breaks "scott"
		   :ylab "number" :xlab "symbol length" :main "symbols in all packages"))
      #-cffi-features:windows (warn "an X server is required for the generation of PNGs")
      (ignore-errors () 
        (with-device ((format nil "~A/symbol-length-cl" path) :png)
          (r-funcall "hist" lengths-cl :breaks "scott"
                     :ylab "number" :xlab "symbol length" :main "symbols in COMMON-LISP"))
        (with-device ((format nil "~A/symbol-length-all" path) :png)
          (r-funcall "hist" lengths-all :breaks "scott"
                     :ylab "number" :xlab "symbol length" :main "symbols in all packages"))))))

(defun ggplot-example (&optional (path #+cffi-features:windows "C:/" 
				       #-cffi-features:windows "/tmp/"))
  (flet ((list-symbols (&optional package &aux symbols)
	   (mapcar #'symbol-name (if package 
				     (do-symbols (s package symbols) (push s symbols))
				     (do-all-symbols (s symbols) (push s symbols)))))) 
    (let ((lengths-cl (mapcar #'length (list-symbols "CL")))
	  (lengths-all (mapcar #'length (list-symbols))))
      (with-device ((format nil "~A/ggplot" path) :pdf)
	(r-funcall "hist" lengths-cl :breaks "scott"
		   :ylab "number" :xlab "symbol length" :main "symbols in COMMON-LISP")
	(r-funcall "hist" lengths-all :breaks "scott"
		   :ylab "number" :xlab "symbol length" :main "symbols in all packages")))))


