;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(cffi:defctype SEXP :pointer)

;;  :type  5  :obj   1  :named 2  :gp    16  :mark 1
;;  :debug 1  :trace 1  :fin   1  :gcgen  1  :gccls 3
(cffi:defcstruct sxpinfo_struct
  (bitfield :unsigned-int))

(cffi:defcstruct primsxp_struct
  (offset :int))

(cffi:defcstruct symsxp_struct
  (pname :pointer)
  (value :pointer)
  (internal :pointer))

(cffi:defcstruct listsxp_struct
  (carval :pointer)
  (cdrval :pointer)
  (tagval :pointer))

(cffi:defcstruct envsxp_struct
  (frame :pointer)
  (enclos :pointer)
  (hashtab :pointer))

(cffi:defcstruct closxp_struct
  (formals :pointer)
  (body :pointer)
  (env :pointer))

(cffi:defcstruct promsxp_struct
  (value :pointer)
  (expr :pointer)
  (env :pointer))

(cffi:defcunion SEXPREC_UNION
 (primsxp (:struct primsxp_struct))
 (symsxp (:struct symsxp_struct))
 (listsxp (:struct listsxp_struct))
 (envsxp (:struct envsxp_struct))
 (closxp (:struct closxp_struct))
 (promsxp (:struct promsxp_struct)))

(cffi:defcstruct SEXPREC
  (sxpinfo (:struct sxpinfo_struct))
  (attrib :pointer)
  (gengc_next_node :pointer)
  (gengc_prev_node :pointer)
  (u (:union SEXPREC_UNION)))

(cffi:defcstruct vecsxp_struct
  (length :int)
  (truelength :int))

(cffi:defcstruct VECTOR_SEXPREC
  (sxpinfo (:struct sxpinfo_struct))
  (attrib :pointer)
  (gengc_next_node :pointer)
  (gengc_prev_node :pointer)
  (vecsxp (:struct vecsxp_struct)))

(cffi:defcunion SEXPREC_ALIGN
  (s (:struct VECTOR_SEXPREC))
  (align :double))

(cffi:defcvar ("R_GlobalEnv" :read-only t) SEXP)
(cffi:defcvar ("R_UnboundValue" :read-only t) SEXP)
(cffi:defcvar ("R_NilValue" :read-only t) SEXP)
;;; seen in RCLG (also the idea of using :read-only)
(cffi:defcvar ("R_InputHandlers" :read-only t) SEXP)
(cffi:defcvar ("R_NamesSymbol" :read-only t) SEXP)
(cffi:defcvar ("R_DimSymbol" :read-only t) SEXP)

(cffi:defcfun "Rf_initEmbeddedR" :int (argc :int) (argv :pointer))
(cffi:defcfun "Rf_initialize_R" :int (argc :int) (argv :pointer))
(cffi:defcfun "setup_Rmainloop" :void)
(cffi:defcfun "end_Rmainloop" :void)
(cffi:defcfun "run_Rmainloop" :void)
(cffi:defcfun "Rf_endEmbeddedR" :void (fatal :int))
(cffi:defcfun "Rf_install" SEXP (str :string))
(cffi:defcfun "Rf_findFun" SEXP (fun SEXP) (rho SEXP))
(cffi:defcfun "Rf_findVar" SEXP (var SEXP) (rho SEXP))
(cffi:defcfun "Rf_eval" SEXP (expr SEXP) (rho SEXP))
(cffi:defcfun "R_tryEval" SEXP (expr SEXP) (rho SEXP) (error :pointer))

(cffi:defcfun "Rf_allocVector" SEXP (type :unsigned-int) (length :int))
(cffi:defcfun "Rf_mkChar" SEXP (string :string))
(cffi:defcfun "Rf_mkString" SEXP (string :string))

;; SEXP Rf_mkCharLen(const char *, int);
;; http://stat.ethz.ch/R-manual/R-devel/doc/manual/R-exts.html#Character-encoding-issues
;; SEXP Rf_mkCharCE(const char *, cetype_t);
;; SEXP Rf_mkCharLenCE(const char *, int, cetype_t);  //new in 2.8.0 

(cffi:defcfun "Rf_protect" SEXP (expr SEXP))
(cffi:defcfun "Rf_unprotect" :void (n :int))
(cffi:defcfun "Rf_unprotect_ptr" :void (expr SEXP))

(cffi:defcfun "R_gc" :void)
