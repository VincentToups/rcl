;; (r "print" (r% "solve" (r% "matrix" '(3 4 1 5 1 5 2 3 5) :nrow 3)))
;R#            [,1]       [,2]        [,3]
;R# [1,]  0.1298701  0.1948052 -0.16883117
;R# [2,]  0.2207792 -0.1688312  0.01298701
;R# [3,] -0.2467532  0.1298701  0.22077922
#<R-MATRIX #2A((0.12987012987012989d0 0.19480519480519481d0
                -0.16883116883116883d0)
               (0.22077922077922082d0 -0.16883116883116883d0
                0.012987012987012986d0)
               (-0.24675324675324678d0 0.12987012987012989d0
                0.22077922077922077d0)) NIL {10071DA343}>

;; (r "library" "Matrix")
("Matrix" "lattice" "stats" "graphics" "grDevices" "utils" "datasets" "methods"
 "base")

;; (r "solve" (r% "Matrix" '(3 4 1 5 1 5 2 3 5) :nrow 3))
;R. (:PACKAGE "Matrix")
;R. (:X 0.1298701298701299d0 0.22077922077922077d0 -0.24675324675324678d0 0.19480519480519476d0 -0.16883116883116883d0 0.1298701298701299d0 -0.16883116883116886d0 0.012987012987013019d0 0.22077922077922077d0)
;R. (:FACTORS)
;R. (:CLASS "dgeMatrix")
(:UNKNOWN NIL)


(reduce #'+
	(r "as.vector" 
	   (r% "-" (r% "solve" (r% "matrix" '(3 4 1 5 1 5 2 3 5) :nrow 3))
	       (r% "as.matrix" (r% "solve" (r% "Matrix" '(3 4 1 5 1 5 2 3 5) :nrow 3))))))

(enable-rcl-syntax)
(reduce #'+
	[as.vector
	[_- [_solve [_matrix '(3 4 1 5 1 5 2 3 5) :nrow 3]]
	[_as.matrix [_solve [_Matrix '(3 4 1 5 1 5 2 3 5) :nrow 3]]]]])

