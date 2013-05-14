;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defvar *print-attributes* nil
  "Print to standard output details about attributes when encountered")

(defvar *r-attributes-prefix* ";R. "
  "Default prefix used to print attributes")

(defun attributes-list (list)
  (if (stringp list)
      (warn "string attribute: ~A" list)
  (unless (and (atom list) (or (eq list :nil) 
			       #+NIL(string= list "unlink")
			       #+NIL(string= list "push.viewport")))
    (unless (= (length list) 3)
      (error "the list doesn't have three elements: ~A" list))
    (unless (typep (third list) 'r-symbol)
      (error "I expected a symbol, I got ~A" (third list)))
    (append (list (cons (intern (string-upcase (name (third list))) "KEYWORD")
			(first list)))
	    (if (and (second list) (not (equal :NIL (second list))))
		(attributes-list (second list)))))))

(defun print-attributes (attributes)
  (let ((*print-pretty* nil))
    (format t 
	    (concatenate 'string "~{"  *r-attributes-prefix* "~S~&~}")
	    attributes)))
