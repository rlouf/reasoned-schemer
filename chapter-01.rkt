#lang racket

(require Racket-miniKanren/miniKanren/mk)
(define succeed (== #t #t))
(define fail (== #t #f))
(define else succeed)
;; TODO: Define #s and #u as shortcuts to succeed and fail respectively

;; 7
(run* (q) fail)                         ; ()

;; 10
(run* (q) (== 'pea 'pod))               ; ()

;; 11
(run* (q) (== q 'pea))                  ; (pea)

;; 12
;; The order of the arguments to == does not matter
(run* (q) (== 'pea q))                  ; (pea)

;; From now one we will omit the outer parentheses from the result value.

;; 16-17
;; The variable q remains fresh
(run* (q) succeed)                      ; _.0

;; 19
(run* (q) (== 'pea 'pea))               ; _.0

;; 20
(run* (q) (== q q))                     ; _.0

;; 21
(run* (q) (fresh (x) (== 'pea q)))      ; pea

;; 24
(run* (q) (fresh (x) (== 'pea x)))      ; _.0

;; 25
(run* (q) (fresh (x) (== (cons x '()) q))) ; (_.0)

;; 26
;; `(,x) is a shorthand for (cons x '())
(run* (q) (fresh (x) (== `(,x) q)))     ; (_.0)

;; 30-31
;; We fuse two fresh variables using ==
(run* (q) (fresh (x) (== x q)))         ; _.0

;; 32
(run* (q) (== '(((pea)) pod) '(((pea)) pod))) ; _.0

;; 33
(run* (q) (== '(((pea)) pod) `(((pea)) ,q))) ; pod

;; 34
(run* (q) (== `(((,q)) pod) '(((pea)) pod))) ; pea

;; 35
(run* (q) (fresh (x) (== `(((,x)) pod) `(((,q)) pod)))) ; _.0

;; 36
(run* (q) (fresh (x) (== `(((,q)) ,x) `(((,x)) pod)))) ; pod

;; 37
(run* (q) (fresh (x) (== `(,x ,x) q))) ; (_.0, _.0)

;; 38
;; Every variable by fresh or run* is initially different from any other variable. Two variables are then different if they have not been fused
(run* (q) (fresh (x) (fresh (y) (== `(,q ,y) `((,x ,y) ,x))))) ; (_.0, _.0)
