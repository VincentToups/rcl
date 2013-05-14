;; Copyright (c) 2006-2007 Carlos Ungil

(declaim (optimize (debug 3)))

(in-package :rcl)

(r-parse-eval "z~x*d")
;; => (LANGUAGE-CONSTRUCT #<R-SYMBOL "~" {12C14171}>
;;     (#<R-SYMBOL "z" {12C16039}>
;;      ((LANGUAGE-CONSTRUCT #<R-SYMBOL "*" {12C18731}>
;;        (#<R-SYMBOL "x" {12C1A601}> (#<R-SYMBOL "d" {12C1C4E1}> :NIL :NIL) :NIL)
;;        :NIL)
;;       :NIL :NIL)
;;      :NIL)
;;     :NIL),

(r-parse-eval "z~x+d")

(r-obj-describe (r%-parse-eval "x~y"))

(let ((environment
       (multiple-value-bind (val att)
	   (r-parse-eval "x~y")
	 (cdr (assoc :.environment att)))))
  (inspect environment))


;;(make-formula '(~ x y))

(defun make-formula (tree)
  (let ((formula (new-language-construct (1+ (count-if-not #'keywordp args)))))
    ;; make-symbols (symsxp-pname, symsxp-value, symsxp-internal)
    ;; make-tree  (listsxp-car, listsxp-cdr, listsxp-tag)
    ;; set attributes: class (.environment?)
    formula))

#|		  ;; named argument passed as two successive arguments :name value
		  (when (keywordp arg)
		    (setf (listsxp-tag list)
			  (rf-install (string-downcase
				       (substitute #\_ #\- (symbol-name arg))))
			  arg (pop args)))
		  ;; named argument passed as cons (:name . value)
		  (when (and (consp arg) (keywordp (car arg)))
		    (setf (listsxp-tag list)
			  (rf-install (string-downcase
				       (substitute #\_ #\- (symbol-name (car arg)))))
			  arg (cdr arg)))
		  (setf (listsxp-car list) (lisp-to-r arg)))))
|#

(defun flatten-r-list (data)
  (if (atom data)
      data
      (let ((car (first data))
	    (cdr (second data))
	    (tag (third data)))
      (unless (eq tag :NIL)
	(error "I can't handle tagged elements: ~A" tag))
      (cons 
       (flatten-r-list car)
       (unless (eq cdr :NIL) (flatten-r-list cdr))))))

'(~ ((- (z (2.0d0 :NIL :NIL) :NIL) :NIL)
     ((+ (k (1.0d0 :NIL :NIL) :NIL) :NIL) :NIL :NIL) :NIL) :NIL)

	  
