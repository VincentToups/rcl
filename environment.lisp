;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defclass r-environment ()
  ((frame :accessor frame :initarg :frame)
   (enclos :accessor enclos :initarg :enclos)
   (hashtab :accessor hashtab :initarg :hashtab)))

(defmethod print-object ((r-environment r-environment) stream) 
  (print-unreadable-object (r-environment stream :type t :identity t)
     (format stream "~s" (frame r-environment))))
