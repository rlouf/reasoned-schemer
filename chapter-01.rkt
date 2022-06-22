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
(run* (q) (fresh (x) (== `(,x) q)))     ; (_.0)

;; 30-31
;; We fuse two fresh variables using ==
(run* (q) (fresh (x) (== x q)))         ; _.0
