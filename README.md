# The Reasoned Schemer

This a Racket implementation of /The Reasoned Schemer/'s examples. To be able to run the example you will need to install the canonical implementation of miniKanren in Racket with:

``` sh
raco pkg install github://github.com/miniKanren/Racket-miniKanren/master
```


# Notes

- The first law of `==`
`(== v w )` can be replaced with `(== w v)`
- Every variable is initially fresh. A variable is no longer fresh if it becomes associated with a non-variable value of if it becomes associated with a variable that, itself, is no longer fresh.
