;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(defvar *r-output* t
  "Default stream where R output will be sent if captured")

(defvar *r-message* t
  "Default stream where R messages will be sent if captured")

(defvar *r-output-prefix* ";R# "
  "Default prefix used to print lines of R output")

(defvar *r-message-prefix* ";R! "
  "Default prefix used to print lines of R messages")

(defmacro with-r-output ((&optional stream prefix) &body body)
  "Capture R output and send it to stream (default *r-output*),
adding a prefix to each line (default *r-output-prefix*)"
  (let ((sink (gensym "SINK-OUT"))
	(result (gensym "RESULT")))
  `(let ((,sink (r-funcall "textConnection" "tmpout" "w"))
	 ,result)
     (r-funcall "sink" :file ,sink :type "output")
     (unwind-protect
	  (setf ,result (progn ,@body))
       (r-funcall "sink" :type "output")
       (r-funcall "close" ,sink)
       (format ,(or stream '*r-output*) 
	       (concatenate 'string "~{"  ,(or prefix '*r-output-prefix*) "~A~&~}")
	       (let ((*extract-single-element* nil))
		 (r-to-lisp (r-variable "tmpout")))))
     ,result)))
  
(defmacro with-r-message ((&optional (stream *r-message*) (prefix *r-message-prefix*)) &body body)
  "Capture R messages and send them to stream (default *r-message*),
adding a prefix to each line (default *r-message-prefix*)"  
  (let ((sink (gensym "SINK-ERR"))
	(result (gensym "RESULT")))
  `(let ((,sink (r-funcall "textConnection" "tmperr" "w"))
	 ,result)
     (r-funcall "sink" :file ,sink :type "message")
     (unwind-protect
	  (setf ,result (progn ,@body))
       (r-funcall "sink" :type "message")
       (r-funcall "close" ,sink)
       (format ,stream (concatenate 'string "~{"  ,prefix "~A~&~}")
	       (let ((*extract-single-element* nil))
		 (r-to-lisp (r-variable "tmperr")))))
     ,result)))

(defmacro with-r-streams (&body body)
  `(with-r-output () (with-r-message () ,@body)))

