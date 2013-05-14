;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(defun get-data-integers (sexp)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec))))
	;;(length (vecsxp-length (sexp-vecsxp sexp))))
	(length (getf (sexp-vecsxp sexp) 'length)))
    (loop for i from 0 below length
       collect (cffi:mem-aref start-data :int i))))

(defun set-data-integers (sexp integers)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec)))))
    (dotimes (i (length integers))
      (setf (cffi:mem-aref start-data :int i) (coerce (elt integers i) 'integer)))))

(defun get-data-reals (sexp)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec))))
	(length (getf (sexp-vecsxp sexp) 'length)))
    (loop for i from 0 below length
       collect (cffi:mem-aref start-data :double i))))

(defun set-data-reals (sexp reals)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec)))))
    (dotimes (i (length reals))
      (setf (cffi:mem-aref start-data :double i) (coerce (elt reals i) 'double-float)))))

(defun get-data-sexps (sexp)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec))))
	(length (getf (sexp-vecsxp sexp) 'length)))
    (loop for i from 0 below length
       collect (cffi:mem-aref start-data '(:pointer (:struct vector_sexprec)) i))))

(defun set-data-sexps (sexp pointers)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec)))))
    (dotimes (i (length pointers))
      (setf (cffi:mem-aref start-data '(:pointer (:struct vector_sexprec)) i) (elt pointers i)))))

(defun get-data-strings (sexp)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec))))
	(length (getf (sexp-vecsxp sexp) 'length)))
    (loop for i from 0 below length
       collect (r-to-lisp (cffi:mem-aref start-data :pointer i)))))

(defun set-data-strings (sexp strings)
  (let ((start-data (cffi:inc-pointer sexp (cffi:foreign-type-size '(:struct vector_sexprec)))))
    (dotimes (i (length strings))
      (setf (cffi:mem-aref start-data :pointer i)
	    (new-internal-char (elt strings i))))))

