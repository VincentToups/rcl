R> (r "attributes" (r% "ar" (r-variable  "lh")))
((:NAMES "order" "ar" "var.pred" "x.mean" "aic" "n.used" "order.max"
  "partialacf" "resid" "method" "series" "frequency" "call" "asy.var.coef")
 (:CLASS . "ar"))

;; the value "SET" is not of type LIST.
R> (r% "print" (r% "ar" (r-variable  "lh")))

;;; the list doesn't have three elements: nsim
R> (r "names" (r% "ar" (r-variable  "lh")))
("order" "ar" "var.pred" "x.mean" "aic" "n.used" "order.max" "partialacf"
 "resid" "method" "series" "frequency" "call" "asy.var.coef")

R> (r "class" (r% "ar" (r-variable  "lh")))
"ar"

R> (r "\$" (r% "ar" (r-variable  "lh")) "asy.var.coef")
(0.02155677601988518d0 -0.015178177365056472d0 0.004815998745644287d0
 -0.015178177365056472d0 0.03116782472289846d0 -0.015178177365056472d0
 0.004815998745644286d0 -0.01517817736505647d0 0.02155677601988518d0)
((:DIM 3 3))

is ok (it's a matrix) but the following is a 3d array and not supported currently

R> (r "\$" (r% "ar" (r-variable  "lh")) "partialacf")
(0.5755244755244756d0 -0.22340997286429742d0 -0.22694020165024148d0
 0.10276837700622231d0 -0.07593441965331013d0 0.06755793452596624d0
 -0.10417025122780985d0 0.012013676148550544d0 -0.18768722846113864d0
 0.0025510411197388885d0 0.06560201323373414d0 0.03196795336021604d0
 0.021882098359407208d0 -0.09312452837866995d0 0.2297876294427684d0
 0.04443989018953477d0)
((:DIM 16 1 1))

