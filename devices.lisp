;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defun device-details (type)
  "Returns for known types :ps, :pdf, :png, :jp[e]g, :xfig, :pictex 
a pair function,extension"
  (values-list (ecase type
		 (:ps '("postscript" "ps"))
		 (:pdf '("pdf" "pdf"))
		 (:png '("png" "png"))
		 ((or :jpeg :jpg) '("jpeg" "jpg"))
		 (:xfig '("xfig" "fig"))
		 (:pictex '("pictex" "tex")))))

(defmacro with-device ((filename type &rest options) &body body)
  "Executes the body after opening a graphical device that is closed at the end; 
options are passed to R (known types: :ps, :pdf, :png, :jp[e]g, :xfig, :pictex)"
  `(multiple-value-bind (device-name device-extension) (device-details ,type)
    (r% device-name (concatenate 'string ,filename "." device-extension) ,@options)
    (let ((device (r% "dev.cur")))
      (unwind-protect
	   (progn ,@body)
	(r% "dev.off" device)))))
