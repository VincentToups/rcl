;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

;; with-r-streams is more robust, but closes all the existing connections

(defun r%-parse-eval (string)
  "Parse and evaluate the string in the R environment (returns r-pointer)"
  ;;(with-r-message () (with-r-output () (r-funcall "eval" (r-funcall "parse" :text string)))))
  (with-r-streams (r-funcall "eval" (r-funcall "parse" :text string))))

(defun r-parse-eval (string)
  "Call r%-parse-eval and decode the result"
  (r-to-lisp (r%-parse-eval string)))

(defun r% (&rest args)
  "Apply the first argument to rest in the R environment (returns r-pointer)"
  ;;(with-r-message () (with-r-output () (apply #'r-funcall args))))
  (with-r-streams (apply #'r-funcall args)))

(defun r (&rest args)
  "Call r% and decode the result"
  (r-to-lisp (apply #'r% args)))

(defun r%-values (&rest args)
  "Like r%, but returning output and messages as additional value"
  (let ((output (make-string-output-stream))
	(message (make-string-output-stream)))
     (values (with-r-message (message "") 
	       (with-r-output (output "") 
		 (apply #'r-funcall args)))
	     (get-output-stream-string output)
	     (get-output-stream-string message))))

;;FIXME this won't work if decoding produces values!
(defun r-values (&rest args)
  "Call r%-values and decode the principal value"
  (let ((output (make-string-output-stream))
	(message (make-string-output-stream)))
    (values (r-to-lisp (with-r-message (message "") 
			    (with-r-output (output "") 
			      (apply #'r-funcall args))))
	     (get-output-stream-string output)
	     (get-output-stream-string message))))
