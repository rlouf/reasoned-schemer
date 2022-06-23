#lang racket

(require Racket-miniKanren/miniKanren/mk)
(define else succeed)
(define fail (== #t #f))

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

;; 40
(run* (q) (fresh (x) (== 'pea q)))      ; 'pea

;; 41
(run* (q) (fresh (x) (fresh (y) (== `(,x ,y) q)))) ; (_.0 _.1)

;; 42
(run* (s)
  (fresh (t)
    (fresh (u)
      (== `(,t ,u) s))))                ; (_.0 _.1)

;; 43
(run* (q)
      (fresh (x)
             (fresh (y)
                    (== `(,x ,y ,x) q)))) ; (_.0, _.1, _.0)

;; 45
(run* (q) (== '(pea) 'pea))             ; ()

;; 46
;; A variable cannot be equal to a list in which the variable occurs.
;; A variable x occurs in a variable y when x appears in the value associated with y.
;; A variable x occurs in a list l when x is an element l or x occurs in an element of l.
(run* (q) (== `(,q) q))                 ; ()

;; 50
(run* (q) succeed succeed)      ; (_.0)

;; 51
(run* (q) succeed (== 'corn q))         ; 'corn

;; 52
(run* (q) fail (== 'corn q))         ; ()

;; TODO: Define conj2

;; 53
(run* (q) (== 'corn q) (== 'meal q))         ; ()

;; 54
(run* (q) (== 'corn q) (== 'corn q))         ; 'corn

;; TODO: Define disj2
;; This could be useful: https://github.com/rymaju/mykanren#disj2
