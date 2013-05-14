;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defclass r-matrix ()
  ((matrix :accessor matrix :initarg :matrix)
   (names :accessor names :initarg :names)))

(defmethod print-object ((matrix r-matrix) stream) 
  (print-unreadable-object (matrix stream :type t :identity t)
    (format stream "~s ~s" (matrix matrix) (names matrix))))
