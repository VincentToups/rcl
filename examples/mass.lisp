(in-package :rcl)

(r ":" -2 2)
;; = (r "seq" -2 2)
;; = (r-parse-eval "-2:2")
;; = (r-parse-eval "seq(-2,2)")
;;(-2 -1 0 1 2)

(r-parse-eval "pi")
;;3.141592653589793d0

(r "class" (r-variable "pi"))
;; = (r-parse-eval "class(pi)")
;;"numeric"

(r "^" (r-variable "pi") (r% ":" -2 2))
;; = (r-parse-eval "pi^(-2:2)")
;;(0.10132118364233778d0 0.3183098861837907d0 1.0d0 3.141592653589793d0 9.869604401089358d0)

(r "factor" '("uk" "us" "no" "au" "uk" "us" "us"))
;;(3 4 2 1 3 4 4)
;;((:LEVELS "au" "no" "uk" "us") (:CLASS . "factor"))

(r "library" "MASS")
;;("MASS" "stats" "graphics" "grDevices" "utils" "datasets" "methods" "base")

(defvar *painters* (r-variable "painters"))

(r-obj-decode *painters*)  ;; CAN'T DECODE PROMISES YET
;;#<R-PROMISE (:UNKNOWN :LANGUAGE-CONSTRUCT) {128A1DC9}>

(r "head" *painters*)
;; ((10 15 8 12 0 15) (8 16 13 16 15 16) (16 4 16 9 8 4) (3 14 7 8 0 14)
;;  (1 1 1 1 1 1))
;; ((:NAMES "Composition" "Drawing" "Colour" "Expression" "School")
;;  (:ROW.NAMES "Da Udine" "Da Vinci" "Del Piombo" "Del Sarto" "Fr. Penni"
;;   "Guilio Romano")
;;  (:CLASS . "data.frame"))

(r "summary" *painters*)
;; ("Min.   : 0.00  " "1st Qu.: 8.25  " "Median :12.50  " "Mean   :11.56  "
;;  "3rd Qu.:15.00  " "Max.   :18.00  " "NA" "Min.   : 6.00  " "1st Qu.:10.00  "
;;  "Median :13.50  " "Mean   :12.46  " "3rd Qu.:15.00  " "Max.   :18.00  " "NA"
;;  "Min.   : 0.00  " "1st Qu.: 7.25  " "Median :10.00  " "Mean   :10.94  "
;;  "3rd Qu.:16.00  " "Max.   :18.00  " "NA" "Min.   : 0.000  " "1st Qu.: 4.000  "
;;  "Median : 6.000  " "Mean   : 7.667  " "3rd Qu.:11.500  " "Max.   :18.000  "
;;  "NA" "A      :10  " "D      :10  " "E      : 7  " "G      : 7  "
;;  "B      : 6  " "C      : 6  " "(Other): 8  ")
;; ((:DIM 7 5)
;;  (:DIMNAMES ("" "" "" "" "" "" "")
;;   (" Composition" "   Drawing" "    Colour" "  Expression" "    School"))
;;  (:CLASS . "table"))

(r "as.matrix" *painters*)
;; ("10" "15" " 8" "12" " 0" "15" " 8" "15" " 4" "17" "10" "13" "10" "15" "13"
;;  "12" "14" "16" "10" "13" "11" "15" " 6" " 4" " 8" " 6" "12" " 5" " 8" "15"
;;  "12" "15" "14" " 6" "13" "15" "18" "14" "15" " 8" " 9" " 4" " 8" "11" "10"
;;  "13" "15" "18" "15" "15" "10" "16" "15" "15" " 8" "16" "13" "16" "15" "16"
;;  "17" "16" "12" "18" "13" "15" "15" "14" "14" "15" "15" "14" "10" "12" "15"
;;  "15" " 8" " 6" " 9" " 8" " 9" " 6" "14" "14" "15" "10" "14" " 6" "13" "17"
;;  "10" "13" "17" "10" "10" "15" " 6" "10" " 8" "14" " 6" "13" "12" "10" " 8"
;;  "16" "15" "17" "16" " 4" "16" " 9" " 8" " 4" " 4" " 7" "10" "12" " 8" " 8"
;;  " 6" " 7" "10" " 5" " 6" "12" " 6" " 9" " 0" "12" "17" "14" "18" "15" "14"
;;  "16" "17" "16" "18" "16" "10" "16" "15" " 9" "10" "10" "13" "10" "16" " 6"
;;  " 6" "14" "16" "10" "17" "17" "13" "17" " 8" " 8" " 4" " 6" " 3" "14" " 7"
;;  " 8" " 0" "14" " 8" " 6" " 4" "18" " 8" " 8" " 6" "10" " 9" " 8" "10" " 6"
;;  " 2" " 6" " 6" "13" " 0" " 0" " 4" " 4" " 6" " 0" " 5" " 4" " 6" " 3" " 6"
;;  " 0" "12" "17" " 4" " 5" "13" " 8" "13" " 6" " 4" " 6" " 6" "10" "12" "17"
;;  " 6" "13" " 4" "16" "15" "15" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "B" "B"
;;  "B" "B" "B" "B" "C" "C" "C" "C" "C" "C" "D" "D" "D" "D" "D" "D" "D" "D" "D"
;;  "D" "E" "E" "E" "E" "E" "E" "E" "F" "F" "F" "F" "G" "G" "G" "G" "G" "G" "G"
;;  "H" "H" "H" "H")
;; ((:DIM 54 5)
;;  (:DIMNAMES
;;   ("Da Udine" "Da Vinci" "Del Piombo" "Del Sarto" "Fr. Penni" "Guilio Romano"
;;    "Michelangelo" "Perino del Vaga" "Perugino" "Raphael" "F. Zucarro"
;;    "Fr. Salviata" "Parmigiano" "Primaticcio" "T. Zucarro" "Volterra" "Barocci"
;;    "Cortona" "Josepin" "L. Jordaens" "Testa" "Vanius" "Bassano" "Bellini"
;;    "Giorgione" "Murillo" "Palma Giovane" "Palma Vecchio" "Pordenone"
;;    "Tintoretto" "Titian" "Veronese" "Albani" "Caravaggio" "Corregio"
;;    "Domenichino" "Guercino" "Lanfranco" "The Carraci" "Durer" "Holbein"
;;    "Pourbus" "Van Leyden" "Diepenbeck" "J. Jordaens" "Otho Venius" "Rembrandt"
;;    "Rubens" "Teniers" "Van Dyck" "Bourdon" "Le Brun" "Le Suer" "Poussin")
;;   ("Composition" "Drawing" "Colour" "Expression" "School")))


(defun group-elements (list dims)
  (let ((size (first dims))
	(nested (rest dims)))
    (when nested
      (setf list (group-elements list nested)))
    (unless (zerop (mod (length list) size)) 
      (error "group size (~A) is not a divisor of list length (~A)" size (length list)))
    (loop for i from 0 below (length list) by size
	  collect (subseq list i (+ i size)))))

(defun r-obj-decode-array (r-pointer)
  (multiple-value-bind (primary attributes)
      (r-obj-decode r-pointer)
    (let* ((dimensions (reverse (rest (find :dim attributes :key #'car)))))
      (make-array dimensions :initial-contents 
		  (group-elements primary (rest dimensions))))))


(r-obj-decode-array (r% "as.matrix" *painters*))
;; #2A(("10" "15" " 8" "12" " 0" "15" " 8" "15" " 4" "17" "10" "13" "10" "15" "13"
;;      "12" "14" "16" "10" "13" "11" "15" " 6" " 4" " 8" " 6" "12" " 5" " 8" "15"
;;      "12" "15" "14" " 6" "13" "15" "18" "14" "15" " 8" " 9" " 4" " 8" "11" "10"
;;      "13" "15" "18" "15" "15" "10" "16" "15" "15")
;;     (" 8" "16" "13" "16" "15" "16" "17" "16" "12" "18" "13" "15" "15" "14" "14"
;;      "15" "15" "14" "10" "12" "15" "15" " 8" " 6" " 9" " 8" " 9" " 6" "14" "14"
;;      "15" "10" "14" " 6" "13" "17" "10" "13" "17" "10" "10" "15" " 6" "10" " 8"
;;      "14" " 6" "13" "12" "10" " 8" "16" "15" "17")
;;     ("16" " 4" "16" " 9" " 8" " 4" " 4" " 7" "10" "12" " 8" " 8" " 6" " 7" "10"
;;      " 5" " 6" "12" " 6" " 9" " 0" "12" "17" "14" "18" "15" "14" "16" "17" "16"
;;      "18" "16" "10" "16" "15" " 9" "10" "10" "13" "10" "16" " 6" " 6" "14" "16"
;;      "10" "17" "17" "13" "17" " 8" " 8" " 4" " 6")
;;     (" 3" "14" " 7" " 8" " 0" "14" " 8" " 6" " 4" "18" " 8" " 8" " 6" "10" " 9"
;;      " 8" "10" " 6" " 2" " 6" " 6" "13" " 0" " 0" " 4" " 4" " 6" " 0" " 5" " 4"
;;      " 6" " 3" " 6" " 0" "12" "17" " 4" " 5" "13" " 8" "13" " 6" " 4" " 6" " 6"
;;      "10" "12" "17" " 6" "13" " 4" "16" "15" "15")
;;     ("A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "B" "B" "B" "B" "B" "B" "C" "C"
;;      "C" "C" "C" "C" "D" "D" "D" "D" "D" "D" "D" "D" "D" "D" "E" "E" "E" "E"
;;      "E" "E" "E" "F" "F" "F" "F" "G" "G" "G" "G" "G" "G" "G" "H" "H" "H" "H"))



(r "print" (r% "array" (loop for i from 1 to 24 collect i) '(4 3 2)))
;R# , , 1
;R# 
;R#      [,1] [,2] [,3]
;R# [1,]    1    5    9
;R# [2,]    2    6   10
;R# [3,]    3    7   11
;R# [4,]    4    8   12
;R# 
;R# , , 2
;R# 
;R#      [,1] [,2] [,3]
;R# [1,]   13   17   21
;R# [2,]   14   18   22
;R# [3,]   15   19   23
;R# [4,]   16   20   24
;R# 
;;(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24)
;;((:DIM 4 3 2))
(r-obj-decode-matrix "print" (r% "array" (loop for i from 1 to 24 collect i) '(4 3 2)))
; Evaluation aborted.
(r-obj-decode-matrix (r% "array" (loop for i from 1 to 24 collect i) '(4 3 2)))
;;#3A(((1 2 3 4) (5 6 7 8) (9 10 11 12))
;;    ((13 14 15 16) (17 18 19 20) (21 22 23 24)))