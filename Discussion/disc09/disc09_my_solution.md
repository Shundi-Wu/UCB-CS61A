# Discussion

#### Question 1: Perfect Fit

**Definition**: A perfect square is `k*k` for some integer `k`.

Implement `fit`, which takes non-negative integers `total` and `n`. It returns whether there are `n` **different** positive perfect squares that sum to `total`.

**Important:** Don't use the Scheme interpreter to tell you whether you've implemented it correctly. Discuss! On the final exam, you won't have an interpreter.

```scheme
; Return whether there are n perfect squares with no repeats that sum to total

    (define (fit total n)
        (define (f total n k)
            (if (and (= n 0) (= total 0))
                #t
            (if (< total (* k k))
                #f
            (or (f total n (+ k 1)) (f (- total (* k k)) (- n 1) (+ k 1)))
            )))
        (f total n 1))

    (expect (fit 10 2) #t)  ; 1*1 + 3*3
    (expect (fit 9 1)  #t)  ; 3*3
    (expect (fit 9 2)  #f)  ;
    (expect (fit 9 3)  #f)  ; 1*1 + 2*2 + 2*2 doesn't count because of repeated 2*2
    (expect (fit 25 1)  #t) ; 5*5
    (expect (fit 25 2)  #t) ; 3*3 + 4*4
```

#### Question 2: Nested Lists

![linked list](https://www.learncs.site/assets/images/make-list-12ce74bfad8d9929f65f1c38d895ad6c.png)

use calls to `list` to construct this list.

```scheme
 (define with-list
        (list
            (list 'a 'b) 'c 'd (list 'e)
        )
    )
    ; (draw with-list)  ; Uncomment this line to draw with-list
```

use `quote` to construct this list

```scheme
(define with-quote
        '( (a b) c d (e)           
        )
)
    ; (draw with-quote)  ; Uncomment this line to draw with-quote
```

Now, use `cons` to construct this list. Don't use `list`. You can use `first` in your answer

```scheme
 (define first
    (cons 'a (cons 'b nil)))
(define with-cons
        (cons
            first (cons 'c (cons 'd (cons (cons 'e nil) nil)))
        )
    )
    ; (draw with-cons)  ; Uncomment this line to draw with-cons
```

#### Question 3: Pair Up

Implement `pair-up`, which takes a list `s`. It returns a list of lists that together contain all of the elements of `s` in order. Each list in the result should have 2 elements. The last one can have up to 3.

```scheme
;;; Return a list of pairs containing the elements of s.
    ;;;
    ;;; scm> (pair-up '(3 4 5 6 7 8))
    ;;; ((3 4) (5 6) (7 8))
    ;;; scm> (pair-up '(3 4 5 6 7 8 9))
    ;;; ((3 4) (5 6) (7 8 9))
    (define (pair-up s)
        (if (<= (length s) 3)
            (list s)
            (cons (list (car s) (car (cdr s))) (pair-up (cdr (cdr s))))
        )
    )

    (expect (pair-up '(3 4 5 6 7 8)) ((3 4) (5 6) (7 8)) )
    (expect (pair-up '(3 4 5 6 7 8 9)) ((3 4) (5 6) (7 8 9)) )
```

