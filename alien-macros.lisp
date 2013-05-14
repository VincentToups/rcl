;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(defmacro new-language-construct (n)
  `(rf-allocvector langsxp ,n))

(defmacro new-integer (n)
  `(rf-allocvector intsxp ,n))

(defmacro new-real (n)
  `(rf-allocvector realsxp ,n))

(defmacro new-complex (n)
  `(rf-allocvector cplxsxp ,n))

(defmacro new-list (n)
  `(rf-allocvector vecsxp ,n))

(defmacro new-logical (n)
  `(rf-allocvector lglsxp ,n))

(defmacro new-character (n)
  `(rf-allocvector strsxp ,n))

(defmacro new-string (n)
  `(rf-allocvector strsxp ,n))

(defmacro new-string-single (string)
  `(rf-mkstring ,string))

(defmacro new-internal-char (string)
  `(rf-mkchar ,string))

(defmacro sexp-attrib (sexp)
  `(cffi:foreign-slot-value ,sexp '(:struct SEXPREC) 'attrib))

(defmacro sexp-next-node (sexp)
  `(cffi:foreign-slot-value ,sexp '(:struct SEXPREC) 'gengc_next_node))

(defmacro sexp-prev-node (sexp)
  `(cffi:foreign-slot-value ,sexp '(:struct SEXPREC) 'gengc_prev_node))

(defmacro sexp-union (sexp)
  `(cffi:foreign-slot-value ,sexp '(:struct SEXPREC) 'u))

(defmacro sexp-vecsxp (sexp)
  `(cffi:foreign-slot-value ,sexp '(:struct VECTOR_SEXPREC) 'vecsxp))

(defmacro sexp-sxpinfo (sexp)
  `(cffi:foreign-slot-value ,sexp '(:struct SEXPREC) 'sxpinfo))

(defmacro sxpinfo-bitfield (sxpinfo)
  `(cffi:foreign-slot-value ,sxpinfo '(:struct sxpinfo_struct) 'bitfield))

(defmacro vecsxp-length (vecsxp)
  `(cffi:foreign-slot-value ,vecsxp '(:struct vecsxp_struct) 'length))

(defmacro vecsxp-true-length (vecsxp)
  `(cffi:foreign-slot-value ,vecsxp '(:struct vecsxp_struct) 'truelength))

(defmacro listsxp-car (listsxp)
  `(cffi:foreign-slot-value ,listsxp '(:struct listsxp_struct) 'carval))

(defmacro listsxp-cdr (listsxp)
  `(cffi:foreign-slot-value ,listsxp '(:struct listsxp_struct) 'cdrval))

(defmacro listsxp-tag (listsxp)
  `(cffi:foreign-slot-value ,listsxp '(:struct listsxp_struct) 'tagval))

;; #define TAG(e)		((e)->u.listsxp.tagval)

(defmacro symsxp-pname (symsxp)
    `(cffi:foreign-slot-value ,symsxp '(:struct symsxp_struct) 'pname))

(defmacro symsxp-value (symsxp)
    `(cffi:foreign-slot-value ,symsxp '(:struct symsxp_struct) 'value))

(defmacro symsxp-internal (symsxp)
    `(cffi:foreign-slot-value ,symsxp '(:struct symsxp_struct) 'internal))


(defmacro promsxp-value (promsxp)
    `(cffi:foreign-slot-value ,promsxp '(:struct promsxp_struct) 'value))

(defmacro promsxp-expr (promsxp)
    `(cffi:foreign-slot-value ,promsxp '(:struct promsxp_struct) 'expr))

(defmacro promsxp-env (promsxp)
    `(cffi:foreign-slot-value ,promsxp '(:struct promsxp_struct) 'env))


(defmacro envsxp-frame (envsxp)
    `(cffi:foreign-slot-value ,envsxp '(:struct envsxp_struct) 'frame))

(defmacro envsxp-enclos (envsxp)
    `(cffi:foreign-slot-value ,envsxp '(:struct envsxp_struct) 'enclos))

(defmacro envsxp-hashtab (envsxp)
    `(cffi:foreign-slot-value ,envsxp '(:struct envsxp_struct) 'hashtab))
