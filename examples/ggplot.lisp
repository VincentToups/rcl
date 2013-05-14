(in-package :rcl)

(r-init)

(enable-rcl-syntax)
[library 'ggplot2]
[print [_qplot 'mpg 'wt :data 'mtcars :size 'cyl :geom '("smooth" "point")]]
[ggsave :filename "/tmp/cars.pdf"]

;;; library(ggplot2)
;;(r "library" "ggplot2")
[library 'ggplot2]
;R! Loading required package: grid
;R! Loading required package: reshape
;R! Loading required package: proto
;R! Loading required package: splines
;R! Loading required package: MASS
;R! Loading required package: RColorBrewer
;R! Loading required package: colorspace

;;; print(mtcars)
;;(r "print" (r-variable "mtcars"))
;;(r "print" '|mtcars|)
[print 'mtcars] ;; [_print 'mtcars] to avoid decoding the output
;R#                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
;R# Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
;R# Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
;R# Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
;R# Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
;R# Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
;R# Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
;R# Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
;R# Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
;R# Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
;R# Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
;R# Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
;R# Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
;R# Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
;R# Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
;R# Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
;R# Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
;R# Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
;R# Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
;R# Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
;R# Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
;R# Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
;R# Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
;R# AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
;R# Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
;R# Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
;R# Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
;R# Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
;R# Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
;R# Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
;R# Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
;R# Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
;R# Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

;;;print(qplot(mpg,wt,data=mtcars,size=cyl)
;; (r "print" (r% "qplot" (r-symbol "mpg") (r-symbol "wt")
;; 	       :data (r-variable "mtcars") :size (r-symbol "cyl")))
;;(r "print" (r% "qplot" '|mpg| '|wt| :data '|mtcars| :size '|cyl|))
[print [_qplot 'mpg 'wt :data 'mtcars :size 'cyl]]

;;(r "ggsave" :filename "/tmp/cars.pdf")
[ggsave :filename "/tmp/cars.pdf"]

;; (r "print" (r% "qplot" (r-symbol "mpg") (r-symbol "wt") 
;; 	       :data (r-variable "mtcars") :size (r-symbol "cyl")
;; 	       :geom '("smooth" "point")))
;; (r "print" (r% "qplot" '|mpg| '|wt| :data '|mtcars| :size '|cyl|
;;	       :geom '("smooth" "point")))
[print [_qplot 'mpg 'wt :data 'mtcars :size 'cyl :geom '("smooth" "point")]]


[ggfluctuation [table [$ 'movies "Action"] [$ 'movies "Comedy"]] :type "colour"]
;R! Error en data[, cols, drop = FALSE] : nÃºmero incorreto de dimensiones

(progn
  [print [_+ [_ggpcp 'mtcars] [_geom_line]]]
  [print [_+ [_ggpcp 'mtcars :scale "var"] [_geom_line]]]
  [print [_+ [_ggpcp 'mtcars :vars [_\[ [_names mtcars] [: 3 6]] :formula ". ~cyl" :scale "I"] [_geom_line]]]
  [print [_+ [_ggpcp 'mtcars :scale "I"] [_geom_boxplot]]]
  [print [_+ [_ggpcp 'mtcars :vars [names [\[ 'mtcars [: 2 6]]] [_geom_line]]]
  )

(let ((p [_ggpcp 'mtcars :vars [_names [_\[ 'mtcars [: 2 6]]] :formula ".~vs"]))
  [print [_+ p [_geom_line [_aes :colour 'mpg]]]])

[print [_plotmatrix 'mtcars]]

R> [attach 'mtcars]
#<R-ENVIRONMENT :NIL {177F1EC9}>
((:NAME . "lazyLoadDBfetch(c(71169L, 1209L), datafile, compressed, envhook)"))
R> [print [_qplot [factor 'cyl] 'wt :geom '("boxplot" "jitter")]]
:NIL
