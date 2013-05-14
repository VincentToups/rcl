;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

;;(defvar *extract-single-element* nil
;;  ;; bad idea in general, the functionality should be fine tuned 
;;  ;; (breaks list of names with a single element, for example)
;;  "If a list contains a single element, return the element instead")

;; the first version worked on PPC, but not on Intel
;; ppc:  671088768   #b 00101 0 00 0000000000000000 1 0 0 0 0 000
;; intel: 16777221   #b 000 0 0 0 0 1 0000000000000000 00 0 00101
;; there is something wrong with openmcl
;;       134217728   #b 00001000 00000000 00000000 00000000 
;; (ldb version of sxpinfo-decode by Alexey Goldin)

#+ppc
(defun sxpinfo-decode (int)
  (let ((type  (ldb (byte 5 27) int))
	(obj   (ldb (byte 1 26) int))
	(named (ldb (byte 2 24) int)) 
	(gp    (ldb (byte 16 8) int))
	(mark  (ldb (byte 1 7) int))
	(debug (ldb (byte 1 6) int))
	(trace (ldb (byte 1 5) int))
	(fin   (ldb (byte 1 4) int))
	(gcgen (ldb (byte 1 3) int)) 
	(gccls (ldb (byte 3 0) int)))
    (list type obj named gp mark debug trace fin gcgen gccls)))

#-ppc
(defun sxpinfo-decode (int)
  (let ((type  (ldb (byte 5 0) int))
	(obj   (ldb (byte 1 5) int))
	(named (ldb (byte 2 6) int)) 
	(gp    (ldb (byte 16 8) int))
	(mark  (ldb (byte 1 24) int))
	(debug (ldb (byte 1 25) int))
	(trace (ldb (byte 1 26) int))
	(fin   (ldb (byte 1 27) int))
	(gcgen (ldb (byte 1 28) int)) 
	(gccls (ldb (byte 3 29) int)))
    (list type obj named gp mark debug trace fin gcgen gccls)))

(defun r-type-decode (n)
  (cdr (assoc n *r-types*)))

(defmethod r-type (sexp)
  (r-type-decode (first (r-header sexp))))

(defmethod r-header (sexp)
  (values
   ;;(sxpinfo-decode (sxpinfo-bitfield (sexp-sxpinfo sexp)))
   (sxpinfo-decode (getf (sexp-sxpinfo sexp) 'bitfield))
   '(type obj named gp mark debug trace fin gcgen gccls)))
 
(defun sexp-unboundp (sexp)
  (= (cffi:pointer-address *r-unboundvalue*)
     (cffi:pointer-address sexp)))

(defun sexp-nilp (sexp)
  (= (cffi:pointer-address *r-nilvalue*)
     (cffi:pointer-address sexp)))

(defmethod r-obj-describe (sexp)
  (cond
    ((sexp-unboundp sexp) :unbound)
    ((sexp-nilp sexp) :nil)
    (t (let ((type (r-type sexp))) type))))
	 ;; (if (member type *r-vector-types*)
	 ;;     (let ((vecsxp (sexp-vecsxp sexp)))
	 ;;       ;;(list type (getf vecsxp :length) (getf vecsxp :truelength))
	 ;;       (list type (vecsxp-length vecsxp) (vecsxp-true-length vecsxp)))
	 ;;     type)))))

(defmethod r-to-lisp (sexp)
  (cond
   ((sexp-unboundp sexp) :unbound)
   ((sexp-nilp sexp) :nil)
   ((equal (r-type sexp) :null) 
    (print "type is :null, but the sexp is not nil")
    nil) ;;overlap with previous line ????
   (t (let ((attributes (attributes-list (r-to-lisp (sexp-attrib sexp)))))
        ;;(unless (or (eq :null (r-type (sexp-attrib sexp)))
        ;;	(eq :scalar-string-type (r-type (sexp-attrib sexp))))
        ;; "unlink" ???
        (when (and attributes (not (equal :list-of-dotted-pairs (r-type (sexp-attrib sexp)))))
          (error "I was expecting the type of the attributes to be :list-of-dotted-pairs, but I got ~A" 
                 (r-type (sexp-attrib sexp))))
        (let ((names (mapcar (lambda (x) (intern x "KEYWORD"))
                             (rest (find :names attributes :key #'first))))
              (attributes (remove :names attributes :key #'first)))
          (let ((dim (rest (find :dim attributes :key #'first)))
                (attributes (remove :dim attributes :key #'first)))
	    (let ((dimnames (rest (find :dimnames attributes :key #'first)))
		  (attributes (remove :dimnames attributes :key #'first)))
	      (when (and *print-attributes* attributes)
		(print-attributes attributes))
	      (if (member (r-type sexp) '(:generic-vector :logical-vector :string-vector
					  :real-vector :integer-vector))
		  (let ((values (ecase (r-type sexp) 
				  (:generic-vector (mapcar #'r-to-lisp (get-data-sexps sexp)))
				  (:logical-vector (mapcar #'plusp (get-data-integers sexp)))			   
				  (:string-vector (get-data-strings sexp))
				  (:real-vector (get-data-reals sexp))
				  (:integer-vector (get-data-integers sexp)))))
		    (if (null names)
			(if dim
			    (make-instance 'r-matrix :matrix (let ((output (make-array dim)))
							       (loop for i from 0 to (1- (first dim))
								     do (loop for j from 0 to (1- (second dim))
									      do (setf (aref output j i) 
										       (pop values))))
							       output)
						     :names dimnames)
			  values)
			(pairlis names values)))
		  (progn
		    (when names 
		      (error "I didn't expect to get names in a non-vector sexp"))
		    (case (r-type sexp)
		      (:symbol
		       (let ((list (sexp-union sexp)))
			 (make-instance 'r-symbol 
					:name (r-to-lisp (symsxp-pname list))
					:value (when (r-to-lisp (symsxp-pname list))
						 (r-to-lisp (symsxp-value list)))
					:internal (r-to-lisp (symsxp-internal list)))))
		      (:list-of-dotted-pairs
		       (let ((list (sexp-union sexp)))
			 (list  (r-to-lisp (listsxp-car list))
				(r-to-lisp (listsxp-cdr list))
				(r-to-lisp (listsxp-tag list)))))
		      (:scalar-string-type
		       (cffi:foreign-string-to-lisp (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec)))))
		      (:promise 
		       (let ((list (sexp-union sexp)))
			 (make-instance 'r-promise
					:value (r-to-lisp (promsxp-value list))
					:expression (r-to-lisp (promsxp-expr list))
					:environment (r-to-lisp (promsxp-env list)))))
		      (:language-construct
		       (let ((list (sexp-union sexp)))
			 (list 
			  'language-construct
			  (r-to-lisp (listsxp-car list))
			  (r-to-lisp (listsxp-cdr list))
			  (r-to-lisp (listsxp-tag list)))))
		      (:closure (list 'closure))
		      (:environments 
		       (let ((list (sexp-union sexp)))
			 (make-instance 'r-environment
					:frame (r-to-lisp (envsxp-frame list))
					:enclos 'unsupported ;;;(r-to-lisp (envsxp-enclos list))
					:hashtab (r-to-lisp (envsxp-hashtab list)))))
		      (t (list :unknown (r-type sexp)))))))))))))
	;;	  (when (and *extract-single-element* (listp result) (car result) (not (cdr result)))
	;;	    (setf result (car result)))
