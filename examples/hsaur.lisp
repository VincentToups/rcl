(in-package :rcl)

(enable-rcl-syntax)

;; 1.2

[install.packages "sandwich"]
;; X11 required to select the CRAN mirror

[library 'sandwich]

;; 1.3 

;; [help "mean"]
;; returns the path to the help file

;; [? "mean"]
;; does the same , but [?mean] doesn't work

[help :package "sandwich"]
;; returns a list with some info

;; [vignette "sandwich"]
;; returns the path to the Rnw and pdf files

;; 1.4

[install.packages "HSAUR"]

[library "HSAUR"]

[data "Forbes2000" :package "HSAUR"]

[ls]
;; tmperr, tmpout are used by RCL to capture R output

[print 'Forbes2000]
;; prints dataframe, returns decoded, extra info as second value

[str 'Forbes2000]
;; prints a description, returns :NIL

;;[help 'Forbes2000]

[class 'Forbes2000]

[dim 'Forbes2000]

[nrow 'Forbes2000]

[ncol 'Forbes2000]

[names 'Forbes2000]

;; Forbes2000[,"rank"]


;; 1.5



;; 1.6



;; 1.7 

[summary 'Forbes2000]

;; 1.8